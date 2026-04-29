import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});
  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String _selectedMethod = 'JazzCash';
  double _amount = 0;
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _confirm() {
    if (_amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Transfer initiated!'),
          backgroundColor: Color(0xFF22C55E)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: Responsive.scaleWidth(context, 28), color: const Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Withdraw Funds',
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 17),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(Responsive.scaleWidth(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance summary card
              _buildBalanceSummary(context),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              // Input header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enter Amount',
                      style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                  GestureDetector(
                    onTap: () {
                      _amountController.text = '14850';
                      setState(() => _amount = 14850);
                    },
                    child: Text('Withdraw All',
                        style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF1E3A8A), fontWeight: FontWeight.w600)),
                  ),
                ],
              ),

              SizedBox(height: Responsive.scaleHeight(context, 12)),

              // The Amount TextField
              _buildAmountField(context),

              SizedBox(height: Responsive.scaleHeight(context, 12)),

              // Quick amount chips
              _buildQuickChips(context),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              // Method selection
              Text('Select Transfer Method',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
              SizedBox(height: Responsive.scaleHeight(context, 12)),
              _buildMethodSelection(context),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              // Fee summary card
              _buildFeeCard(context),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: Responsive.scaleHeight(context, 54),
                child: ElevatedButton.icon(
                  onPressed: _confirm,
                  icon: const Icon(Icons.swap_horiz, color: Color(0xFF1A1A2E)),
                  label: Text('Confirm Transfer',
                      style: TextStyle(fontSize: Responsive.fontSize(context, 16), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBB700),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 16)),
              const Center(
                child: Text('Settlement can take up to 2 hours',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF1E3A8A),
            radius: 18,
            child: Icon(Icons.account_balance_wallet, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('TOTAL BALANCE', style: TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFF9CA3AF))),
              Text('Rs. 14,850.00',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 18), fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField(BuildContext context) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: Responsive.fontSize(context, 22), fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E)),
      onChanged: (v) => setState(() => _amount = double.tryParse(v) ?? 0),
      decoration: InputDecoration(
        prefixText: 'Rs. ',
        prefixStyle: const TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400),
        hintText: '0.00',
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }

  Widget _buildQuickChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['1000', '5000', '10000'].map((v) {
          return GestureDetector(
            onTap: () {
              _amountController.text = v;
              setState(() => _amount = double.parse(v));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text('Rs. $v', style: const TextStyle(fontSize: 12, color: Color(0xFF374151), fontWeight: FontWeight.w600)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMethodSelection(BuildContext context) {
    return Row(
      children: ['JazzCash', 'EasyPaisa'].map((m) {
        bool active = m == _selectedMethod;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedMethod = m),
            child: Container(
              margin: EdgeInsets.only(right: m == 'JazzCash' ? 10 : 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF1E3A8A) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: active ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      color: active ? Colors.white : const Color(0xFF9CA3AF), size: 28),
                  const SizedBox(height: 8),
                  Text(m, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? Colors.white : const Color(0xFF1A1A2E))),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          _feeRow('Platform Fee', 'Rs. 25.00', false),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
          _feeRow('Amount to Receive', 'Rs. ${_amount > 25 ? (_amount - 25).toStringAsFixed(2) : "0.00"}', true),
        ],
      ),
    );
  }

  Widget _feeRow(String label, String value, bool bold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: bold ? const Color(0xFF1A1A2E) : const Color(0xFF6B7280), fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
        Text(value, style: TextStyle(fontSize: 14, color: bold ? const Color(0xFF1E3A8A) : const Color(0xFF1A1A2E), fontWeight: bold ? FontWeight.w800 : FontWeight.w600)),
      ],
    );
  }
}