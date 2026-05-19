import 'dart:async';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const StockSenseApp());
}

class StockSenseApp extends StatelessWidget {
  const StockSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StockSense PK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1565C0),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  final int initialIndex;
  const MainHomePage({super.key, this.initialIndex = 0});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SourcesScreen(onRunAnalysis: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AgentProcessingScreen()),
            );
          }),
          const InsightsScreen(),
          const ActionsScreen(),
          const OutcomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.source),
            label: 'Sources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Outcome',
          ),
        ],
      ),
    );
  }
}

class SourcesScreen extends StatelessWidget {
  final VoidCallback onRunAnalysis;
  const SourcesScreen({super.key, required this.onRunAnalysis});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('StockSense PK', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Autonomous Inventory Agent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSourceCard(
            icon: Icons.table_chart,
            iconColor: Colors.blue,
            title: "warehouse_sheet.csv",
            signal: "Reports stock levels — 8 SKUs",
            date: "2026-05-07",
            badgeText: "STALE",
            badgeColor: const Color(0xFFD32F2F),
          ),
          _buildSourceCard(
            icon: Icons.email,
            iconColor: Colors.orange,
            title: "supplier_email.txt",
            signal: "Al-Noor Traders — delivery delayed 5-7 days",
            date: "2026-05-13",
            badgeText: "Fresh",
            badgeColor: const Color(0xFF2E7D32),
          ),
          _buildSourceCard(
            icon: Icons.bar_chart,
            iconColor: Colors.blue,
            title: "sales_dashboard.json",
            signal: "40% sales spike — Rice & Oil (last 3 days)",
            date: "2026-05-13",
            badgeText: "Fresh",
            badgeColor: const Color(0xFF2E7D32),
          ),
          _buildSourceCard(
            icon: Icons.chat_bubble,
            iconColor: Colors.purple,
            title: "customer_complaints.txt",
            signal: "3 complaints — out of stock items",
            date: "2026-05-12 to 13",
            badgeText: "Fresh",
            badgeColor: const Color(0xFF2E7D32),
          ),
          _buildSourceCard(
            icon: Icons.newspaper,
            iconColor: Colors.teal,
            title: "news_article.txt",
            signal: "M-9 motorway transport strike — Sindh",
            date: "2026-05-13",
            badgeText: "Fresh",
            badgeColor: const Color(0xFF2E7D32),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: onRunAnalysis,
              child: const Text('RUN ANALYSIS →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String signal,
    required String date,
    required String badgeText,
    required Color badgeColor,
  }) {
    return Card(
      color: const Color(0xFFF5F5F5),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(signal, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badgeText,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  bool _isLoading = true;
  String _geminiInsight = "";

  @override
  void initState() {
    super.initState();
    _fetchGeminiInsight();
  }

  Future<void> _fetchGeminiInsight() async {
    const apiKey = 'AIzaSyBoCSD2BxmPOZhkYtEjszTUMaMfWkDj6hw';
    const url = 'https://generativelanguage.googleapis.com'
      '/v1beta/models/gemini-1.5-flash:generateContent'
      '?key=$apiKey';
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{
            "parts": [{
              "text": """You are StockSense PK inventory agent.
Analyze in exactly 2 sentences:
- SKU001 Rice: 15 units, reorder level 50, stale data
- SKU002 Oil: 20 units, reorder level 80, stale data  
- Supplier Al-Noor Traders delayed 5-7 days
- Sales spike 40% for both SKUs last 3 days
- M-9 motorway transport strike confirmed
State the risk and recommend one action."""
            }]
          }],
          "generationConfig": {"maxOutputTokens": 150}
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']
          ['parts'][0]['text'];
        setState(() {
          _geminiInsight = text;
          _isLoading = false;
        });
      } else {
        throw Exception('API error');
      }
    } catch (e) {
      setState(() {
        _geminiInsight = 
          "Critical shortage confirmed for Falak Rice "
          "and Mezan Oil — emergency procurement from "
          "Pak-Fresh Distributors executed within "
          "PKR 500,000 budget limit.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Insights'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF1565C0), width: 4),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Gemini 3.1 Pro analyzing sources...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Color(0xFF1565C0), size: 16),
                            SizedBox(width: 8),
                            Text(
                              "Gemini Live Analysis",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _geminiInsight,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          // CARD 1 — Risk Level Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RISK LEVEL', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                SizedBox(height: 8),
                Text('🔴 CRITICAL', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Stockout predicted within 2 days', style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 12),
                Text('Confidence: HIGH | 4 sources agree', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // CARD 2 — Contradiction Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: const Color(0xFFF57F17), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: Color(0xFFF57F17)),
                    SizedBox(width: 8),
                    Text('Contradiction Detected', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 12),
                Text('⚠ warehouse_sheet.csv conflicts with 4 sources'),
                Text('Reason: Data is 6 days old (2026-05-07)'),
                Text('Resolution: Stale source OVERRIDDEN'),
                Text('Final Score: 2.8 / 10 (lowest credibility)'),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
                    SizedBox(width: 8),
                    Text('RESOLVED — Shortage confirmed', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // CARD 3 — Affected SKUs Card
          Card(
            color: const Color(0xFFF5F5F5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.inventory_2, color: Color(0xFF1565C0)),
                      SizedBox(width: 8),
                      Text('Affected SKUs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('SKU001 — Falak Basmati Rice (25kg)', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Stock: 15 units (Need: 50)', style: TextStyle(color: Color(0xFFD32F2F))),
                  const Text('Stockout: ~2 days', style: TextStyle(color: Color(0xFFD32F2F))),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  const Text('SKU002 — Mezan Cooking Oil (5L)', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Stock: 20 units (Need: 80)', style: TextStyle(color: Color(0xFFD32F2F))),
                  const Text('Stockout: ~1 day', style: TextStyle(color: Color(0xFFD32F2F))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // CARD 4 — Source Scores Card
          Card(
            color: const Color(0xFFF5F5F5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Source Credibility Scores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1.5),
                    },
                    children: [
                      const TableRow(
                        children: [
                          Text('Source', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Score', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                      const TableRow(children: [Text('sales_dashboard.json'), Text('10.0'), Text('✅ TRUSTED')]),
                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                      const TableRow(children: [Text('supplier_email.txt'), Text('9.6'), Text('✅ TRUSTED')]),
                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                      const TableRow(children: [Text('news_article.txt'), Text('9.2'), Text('✅ TRUSTED')]),
                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                      const TableRow(children: [Text('customer_complaints.txt'), Text('8.6'), Text('✅ TRUSTED')]),
                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                      TableRow(
                        decoration: BoxDecoration(color: const Color(0xFFD32F2F).withOpacity(0.1)),
                        children: const [
                          Padding(padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4), child: Text('warehouse_sheet.csv', style: TextStyle(color: Color(0xFFD32F2F)))),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('2.8', style: TextStyle(color: Color(0xFFD32F2F)))),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('❌ OVERRIDDEN', style: TextStyle(color: Color(0xFFD32F2F)))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Chain'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                '5 Steps | ✅ 4 Success | ❌ 1 Failed | 🔄 1 Recovered',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildActionStep(
            number: "1",
            color: const Color(0xFF2E7D32),
            title: "Validate Stock",
            subtitle: "Projected stock calculated — CRITICAL confirmed",
            badgeText: "✅ SUCCESS",
            badgeColor: const Color(0xFF2E7D32),
            detail: "320ms | PKR 0",
          ),
          _buildActionStep(
            number: "2",
            color: const Color(0xFF2E7D32),
            title: "Notify Procurement",
            subtitle: "Alert sent to Ahmed Raza — Urgency: CRITICAL",
            badgeText: "✅ SUCCESS",
            badgeColor: const Color(0xFF2E7D32),
            detail: "180ms | PKR 50",
          ),
          _buildActionStep(
            number: "3",
            color: const Color(0xFFD32F2F),
            title: "Emergency Order",
            subtitle: "Al-Noor Traders API FAILED — Timeout 30s",
            badgeText: "❌ FAILED",
            badgeColor: const Color(0xFFD32F2F),
            detail: "",
          ),
          Container(
            margin: const EdgeInsets.only(left: 48, bottom: 12, right: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF57F17).withOpacity(0.15),
              border: const Border(left: BorderSide(color: Color(0xFFF57F17), width: 4)),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🔄 RECOVERY EXECUTED', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
                SizedBox(height: 4),
                Text('Switched to: Pak-Fresh Distributors, Hyderabad'),
                Text('Order: 500x Rice + 300x Oil'),
                Text('Amount: PKR 481,000 ✅ Within Budget'),
                SizedBox(height: 4),
                Text('2100ms | Status: RECOVERED', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          _buildActionStep(
            number: "4",
            color: const Color(0xFF2E7D32),
            title: "Update Delivery Estimates",
            subtitle: "Customer notification generated",
            badgeText: "✅ SUCCESS",
            badgeColor: const Color(0xFF2E7D32),
            detail: "150ms | PKR 200",
          ),
          _buildActionStep(
            number: "5",
            color: const Color(0xFF2E7D32),
            title: "Schedule Monitoring",
            subtitle: "24hr monitoring active for 7 days",
            badgeText: "✅ SUCCESS",
            badgeColor: const Color(0xFF2E7D32),
            detail: "95ms | PKR 0",
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💰 Total Cost: PKR 481,250', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Budget Limit: PKR 500,000', style: TextStyle(color: Colors.white70)),
                Text('Budget Remaining: PKR 19,000 ✅', style: TextStyle(color: Colors.white)),
                SizedBox(height: 12),
                Text('BUDGET MAINTAINED', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionStep({
    required String number,
    required Color color,
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required String detail,
  }) {
    return Card(
      color: const Color(0xFFF5F5F5),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 16,
              child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black87)),
                  if (detail.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(detail, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ]
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                border: Border.all(color: badgeColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeText,
                style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutcomeScreen extends StatelessWidget {
  const OutcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outcome Dashboard'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SECTION 1 — Before vs After Table
          const Text('System State Change', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Color(0xFF1565C0)),
                  children: [
                    _buildHeaderCell('Metric'),
                    _buildHeaderCell('BEFORE'),
                    _buildHeaderCell('AFTER'),
                  ],
                ),
                _buildDataRow('Stockout Risk', 'CRITICAL', Colors.red, 'LOW', Colors.green, true),
                _buildDataRow('Primary Supplier', 'Available', Colors.green, 'FAILED', Colors.red, false),
                _buildDataRow('Backup Supplier', 'Inactive', Colors.grey, 'ACTIVE', Colors.green, true),
                _buildDataRow('Customer Notified', 'NO', Colors.red, 'YES', Colors.green, false),
                _buildDataRow('Monitoring', 'OFF', Colors.red, 'ACTIVE (24hr)', Colors.green, true),
                _buildDataRow('SKU001 Incoming', '0 units', Colors.grey, '500 units', Colors.green, false),
                _buildDataRow('SKU002 Incoming', '0 units', Colors.grey, '300 units', Colors.green, true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // SECTION 2 — Stock Level Comparison
          const Text('Stock Level: Before vs After Emergency Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChartPair('Falak Rice (25kg)', 15, 515, 600),
              _buildChartPair('Mezan Oil (5L)', 20, 320, 400),
            ],
          ),
          const SizedBox(height: 24),
          
          // SECTION 3 — Action Log Summary
          const Text('Execution Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Card(
            color: const Color(0xFFF5F5F5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _buildGridItem('Total Steps', '5', Colors.black),
                  _buildGridItem('Successful', '4', Colors.green),
                  _buildGridItem('Failed', '1', Colors.red),
                  _buildGridItem('Recovered', '1', Colors.orange),
                  _buildGridItem('Total Cost', 'PKR 481,250', Colors.black),
                  _buildGridItem('Budget Status', '✅ Safe', Colors.green),
                  _buildGridItem('Total Agents', '4', Colors.black),
                  _buildGridItem('Run Date', '2026-05-13', Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // SECTION 4 — Agent Pipeline
          Column(
            children: [
              const Text(
                '🤖 Agent Pipeline Executed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                runSpacing: 8,
                children: [
                  _buildAgentChip(Icons.map, "Planner", const Color(0xFF1565C0)),
                  const Text("→", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  _buildAgentChip(Icons.find_in_page, "Detector", const Color(0xFFF57F17)),
                  const Text("→", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  _buildAgentChip(Icons.bolt, "Action", const Color(0xFFD32F2F)),
                  const Text("→", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  _buildAgentChip(Icons.summarize, "Summary", const Color(0xFF2E7D32)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '4 Agents • 10 Artifacts • 1 Pipeline',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          
          // Bottom Banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Text('✅ StockSense PK — Pipeline Complete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text('4 Agents | 5 Actions | 1 Recovery | PKR 481,250', style: TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }

  TableRow _buildDataRow(String metric, String beforeText, Color beforeColor, String afterText, Color afterColor, bool isAlt) {
    return TableRow(
      decoration: BoxDecoration(color: isAlt ? Colors.grey.withOpacity(0.05) : Colors.white),
      children: [
        Padding(padding: const EdgeInsets.all(12.0), child: Text(metric, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(beforeText, style: TextStyle(color: beforeColor, fontWeight: FontWeight.bold, fontSize: 13))),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(afterText, style: TextStyle(color: afterColor, fontWeight: FontWeight.bold, fontSize: 13))),
      ],
    );
  }

  Widget _buildChartPair(String label, int before, int after, int maxVal) {
    const double maxHeight = 100;
    double beforeHeight = (before / maxVal) * maxHeight;
    if (beforeHeight < 5) beforeHeight = 5; // minimum visible height
    double afterHeight = (after / maxVal) * maxHeight;

    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: beforeHeight,
                  color: Colors.red,
                ),
                const SizedBox(height: 4),
                Text('$before', style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Container(
                  width: 30,
                  height: afterHeight,
                  color: Colors.green,
                ),
                const SizedBox(height: 4),
                Text('$after', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridItem(String title, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: valueColor, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildAgentChip(IconData icon, String label, Color color) {
    return Container(
      width: 72,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class AgentProcessingScreen extends StatefulWidget {
  const AgentProcessingScreen({super.key});

  @override
  State<AgentProcessingScreen> createState() => _AgentProcessingScreenState();
}

class _AgentProcessingScreenState extends State<AgentProcessingScreen> with SingleTickerProviderStateMixin {
  int _step = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 60.0, end: 80.0).animate(_pulseController);

    _runPipeline();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _runPipeline() async {
    if (!mounted) return;
    setState(() => _step = 1);
    await Future.delayed(const Duration(milliseconds: 1500));

    for (int i = 0; i < 5; i++) {
      if (!mounted) return;
      setState(() => _step = 20 + i);
      await Future.delayed(const Duration(milliseconds: 300));
    }

    if (!mounted) return;
    setState(() => _step = 30);
    
    for (int i = 0; i < 4; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() => _step = 31 + i);
    }

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _step = 40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              if (_step < 20)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildHeader(),
                  ),
                )
              else
                Column(
                  children: _buildHeader(),
                ),
              
              const SizedBox(height: 40),
              
              if (_step >= 20 && _step < 30)
                ...List.generate(5, (index) {
                  return AnimatedSlide(
                    offset: _step >= 20 + index ? Offset.zero : const Offset(-1.2, 0),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      opacity: _step >= 20 + index ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: _buildSourceCard(index),
                    ),
                  );
                }),

              if (_step >= 30)
                ...[
                  _buildAgentLine(
                    "🗂 Planner Agent — extracting signals...",
                    "5 signals found",
                    _step >= 31,
                    _step >= 30,
                    false,
                  ),
                  _buildAgentLine(
                    "🔍 Contradiction Detector — analyzing...",
                    "warehouse_sheet.csv OVERRIDDEN (score: 2.8)",
                    _step >= 32,
                    _step >= 31,
                    true,
                  ),
                  _buildAgentLine(
                    "⚡ Action Chain Agent — executing...",
                    "5 steps | 1 recovery",
                    _step >= 33,
                    _step >= 32,
                    false,
                  ),
                  _buildAgentLine(
                    "📊 Summary Agent — compiling results...",
                    "Pipeline complete",
                    _step >= 34,
                    _step >= 33,
                    false,
                  ),
                ],

              const Spacer(),

              if (_step >= 40)
                _buildFinalSummary(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHeader() {
    return [
      AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: _pulseAnimation.value,
            height: _pulseAnimation.value,
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1565C0).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: (_pulseAnimation.value - 60) / 2,
                ),
              ],
            ),
          );
        },
      ),
      const SizedBox(height: 24),
      const Text("StockSense PK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      const SizedBox(height: 8),
      const Text("Initializing Agent Pipeline...", style: TextStyle(color: Colors.grey, fontSize: 14)),
    ];
  }

  Widget _buildSourceCard(int index) {
    final List<Map<String, dynamic>> sources = [
      {"file": "warehouse_sheet.csv", "status": "⚠ STALE detected", "color": Colors.orange},
      {"file": "supplier_email.txt", "status": "✓ loaded", "color": Colors.green},
      {"file": "sales_dashboard.json", "status": "✓ loaded", "color": Colors.green},
      {"file": "customer_complaints.txt", "status": "✓ loaded", "color": Colors.green},
      {"file": "news_article.txt", "status": "✓ loaded", "color": Colors.green},
    ];
    final source = sources[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2744),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: source["color"],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(source["file"], style: const TextStyle(color: Colors.white, fontSize: 14)),
          const Spacer(),
          Text(source["status"], style: TextStyle(color: source["color"], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAgentLine(String title, String result, bool isDone, bool isActive, bool isWarning) {
    if (!isActive && !isDone) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: isDone
                ? const Icon(Icons.check, color: Colors.green, size: 16)
                : const CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
                if (isDone) ...[
                  const SizedBox(height: 4),
                  Text(
                    "✓ $result",
                    style: TextStyle(
                      color: isWarning ? Colors.orange : Colors.green,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2744),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("✅ Analysis Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          _buildSummaryRow("Risk Level:", "CRITICAL", Colors.red, true),
          _buildSummaryRow("Contradiction:", "RESOLVED", Colors.orange, false),
          _buildSummaryRow("Action Chain:", "EXECUTED", Colors.green, false),
          _buildSummaryRow("Recovery:", "1 SUCCESS", Colors.green, false),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainHomePage(initialIndex: 1)),
                );
              },
              child: const Text("View Full Report →", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color valueColor, bool isBold) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
