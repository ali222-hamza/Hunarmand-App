import 'package:flutter/material.dart';

// Chat Screen - Screen 24 in design PDF
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgController = TextEditingController();
  final _scrollController = ScrollController();

  // Sample messages list
  final List<Map<String, dynamic>> _messages = [
    {'text': "Hi, I've booked you for the plumbing repair at my residence in Gulberg.", 'isMe': false, 'time': '10:30 AM'},
    {'text': "Assalam-o-Alaikum! Received. I am just finishing up my current task and will head over.", 'isMe': true, 'time': '10:32 AM', 'read': true},
    {'text': "Great. Please bring a 1/2 inch pipe connector. The leak is under the kitchen sink.", 'isMe': false, 'time': '10:35 AM'},
    {'text': "Understood. I have the tools. See you soon.", 'isMe': true, 'time': '10:36 AM', 'read': true},
    {'text': "Are you reaching the location by 2 PM? I have a meeting later.", 'isMe': false, 'time': '11:45 AM'},
  ];

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'isMe': true,
        'time': _currentTime(),
        'read': false,
      });
    });
    _msgController.clear();

    // scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    DateTime now = DateTime.now();
    String h = now.hour > 12 ? (now.hour - 12).toString() : now.hour.toString();
    String m = now.minute.toString().padLeft(2, '0');
    String period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFE5E7EB),
              child: Icon(Icons.person, color: Colors.grey.shade500, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('Bilal Ahmad', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Date + SOS row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Today, Oct 24', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/emergency'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEF4444)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: Color(0xFFEF4444)),
                          SizedBox(width: 5),
                          Text('SOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFEF4444))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Active job card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(color: Color(0xFFDBEAFE), shape: BoxShape.circle),
                      child: const Icon(Icons.info_outline, size: 16, color: Color(0xFF1E3A8A)),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ACTIVE JOB #8421', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF1E3A8A), letterSpacing: 0.5)),
                        Text('Plumbing Repair - Gulberg III', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Color(0xFF1E3A8A), size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Messages list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, i) {
                  final msg = _messages[i];
                  bool isMe = msg['isMe'] as bool;
                  return _MessageBubble(msg: msg, isMe: isMe);
                },
              ),
            ),

            // Typing indicator
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('••• Bilal is typing...', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF), fontStyle: FontStyle.italic)),
              ),
            ),

            // Input bar
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Row(
                children: [
                  // Attachment
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Color(0xFF9CA3AF), size: 22),
                    onPressed: () {},
                  ),

                  // Text input
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _msgController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),

                  // Image icon
                  IconButton(
                    icon: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 22),
                    onPressed: () {},
                  ),

                  // Send button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E3A8A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> msg;
  final bool isMe;
  const _MessageBubble({required this.msg, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFFE5E7EB),
              child: Icon(Icons.person, size: 16, color: Colors.grey.shade500),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF1E3A8A) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(isMe ? 14 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 14),
                    ),
                    border: isMe ? null : Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Text(
                    msg['text'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : const Color(0xFF1A1A2E),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(msg['time'], style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                    if (isMe && msg['read'] == true) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all, size: 12, color: Color(0xFF1E3A8A)),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}