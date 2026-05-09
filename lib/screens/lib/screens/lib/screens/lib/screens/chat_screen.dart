import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:mime/mime.dart';
import '../theme.dart';
import '../services/ai_service.dart';
import '../services/call_service.dart';
import '../services/voice_assistant_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AIService _ai = AIService();
  final CallService _callService = CallService();
  final VoiceAssistantService _voiceService = VoiceAssistantService();
  final List<ChatMessage> _messages = [];

  late AnimationController _typingCtrl;
  late Animation<double> _typingAnim;

  @override
  void initState() {
    super.initState();
    _typingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _typingAnim = Tween<double>(begin: 0.4, end: 1.0).animate(_typingCtrl);

    _addMessage("isa", "Hello Master. Isa + Jarvis Prime ready.");
    _callService.listenForIncoming((number) {
      _addMessage("system", "📞 Incoming call from $number", null);
    });
    _voiceService.initialize(onCommandReceived: (text) {
      _handleUserMessage(text);
    });
  }

  @override
  void dispose() {
    _typingCtrl.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addMessage(String role, String content, File? file) {
    _messages.add(ChatMessage(role: role, content: content, file: file));
    setState(() {});
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleUserMessage(String text) {
    _addMessage("user", text, null);
    _controller.clear();
    // Show typing indicator
    setState(() => _messages.add(ChatMessage(role: "isa", content: "...", file: null)));
    _ai.ask(text).then((reply) {
      setState(() => _messages.removeLast());
      _handleReply(reply);
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _handleUserMessage(text);
  }

  void _handleReply(String reply) {
    if (reply.startsWith('ACTION_CALL:')) {
      final number = reply.split(':')[1];
      _callService.makeCall(number);
      _addMessage("isa", "Calling $number...", null);
    } else if (reply.startsWith('FILE:')) {
      final parts = reply.split('|');
      final url = parts[0].replaceFirst('FILE:', '');
      final msg = parts.length > 1 ? parts[1] : '';
      _addMessage("isa", msg, null);
      // Optionally download and show file
    } else {
      _addMessage("isa", reply, null);
    }
  }

  Future<void> _pickAndSend(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: source, imageQuality: 80);
    if (picked != null) {
      final file = File(picked.path);
      _addMessage("user", "📷 Image", file);
      setState(() => _messages.add(ChatMessage(role: "isa", content: "...", file: null)));
      final reply = await _ai.sendFile("Analyze this image", file);
      setState(() => _messages.removeLast());
      _handleReply(reply);
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;
      _addMessage("user", "📁 $fileName", file);
      setState(() => _messages.add(ChatMessage(role: "isa", content: "...", file: null)));
      final reply = await _ai.sendFile("Process this file", file);
      setState(() => _messages.removeLast());
      _handleReply(reply);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _buildMessage(_messages[i]),
          ),
        ),
        // Attachment buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white70),
              onPressed: () => _pickAndSend(ImageSource.camera),
            ),
            IconButton(
              icon: const Icon(Icons.photo_library, color: Colors.white70),
              onPressed: () => _pickAndSend(ImageSource.gallery),
            ),
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.white70),
              onPressed: _pickFile,
            ),
            IconButton(
              icon: const Icon(Icons.phone, color: Colors.white70),
              onPressed: () {
                // Quick call UI (simplified)
              },
            ),
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.white70),
              onPressed: () => _voiceService.startListening(),
            ),
          ],
        ),
        // Input bar
        SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppTheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                Material(
                  color: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: _sendMessage,
                    borderRadius: BorderRadius.circular(18),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(ChatMessage msg) {
    final isUser = msg.role == 'user';
    final isSystem = msg.role == 'system';
    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Chip(
            label: Text(msg.content, style: const TextStyle(fontSize: 12)),
            backgroundColor: Colors.white10,
          ),
        ),
      );
    }
    if (msg.content == '...') {
      return _buildTypingIndicator();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: Color(0xFF6C63FF),
                radius: 14,
                child: Icon(Icons.memory, color: Colors.white, size: 16),
              ),
            ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: AppTheme.glassBubble(isUser),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (msg.file != null) _buildFilePreview(msg.file!),
                  if (msg.content.isNotEmpty)
                    Text(
                      msg.content,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isUser)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                radius: 14,
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Color(0xFF6C63FF),
              radius: 14,
              child: Icon(Icons.memory, color: Colors.white, size: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.glassBubble(false),
            child: FadeTransition(
              opacity: _typingAnim,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.white38),
                  SizedBox(width: 4),
                  Icon(Icons.circle, size: 8, color: Colors.white38),
                  SizedBox(width: 4),
                  Icon(Icons.circle, size: 8, color: Colors.white38),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(File file) {
    final mime = lookupMimeType(file.path) ?? '';
    if (mime.startsWith('image/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(file, width: 150, height: 150, fit: BoxFit.cover),
      );
    } else if (mime.startsWith('video/')) {
      return const Icon(Icons.videocam, size: 48, color: Colors.white);
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insert_drive_file, color: Colors.white),
          const SizedBox(width: 8),
          Text(file.path.split('/').last,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      );
    }
  }
}

class ChatMessage {
  final String role;
  final String content;
  final File? file;
  ChatMessage({required this.role, required this.content, this.file});
}

// Note: AppTheme.glassBubble(bool isUser) must be defined in theme.dart like:
// static BoxDecoration glassBubble(bool isUser) {
//   return BoxDecoration(
//     color: isUser ? const Color(0xFF6C63FF).withOpacity(0.25) : Colors.white.withOpacity(0.06),
//     borderRadius: BorderRadius.only(
//       topLeft: const Radius.circular(20),
//       topRight: const Radius.circular(20),
//       bottomLeft: Radius.circular(isUser ? 20 : 4),
//       bottomRight: Radius.circular(isUser ? 4 : 20),
//     ),
//     border: Border.all(color: isUser ? const Color(0xFF6C63FF).withOpacity(0.3) : Colors.white.withOpacity(0.08)),
//   );
// }
