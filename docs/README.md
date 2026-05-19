

# StockSense PK 🇵🇰
### Autonomous Inventory Intelligence Agent
**AI Seekho 2026 Hackathon — Challenge 1**
*Autonomous Content-to-Action Agent (Insight → Action System)*

---

## 1. PROJECT OVERVIEW

StockSense PK is an agentic AI system that transforms 
unstructured multi-source inventory data into autonomous 
actionable outcomes. The system ingests 5 heterogeneous 
input sources, extracts meaningful insights, detects 
contradictions between conflicting data sources, executes 
a 5-step action chain with constraint checking, recovers 
from failures automatically, and presents a before/after 
outcome dashboard — all orchestrated through Google 
Antigravity's multi-agent pipeline.

This is NOT a summarization tool. Every insight leads 
to a concrete simulated action with visible state change.

---

## 2. ARCHITECTURE

### Agent Pipeline
INPUT SOURCES (5)
↓
PLANNER AGENT
→ Reads all 5 sources
→ Extracts key signals
→ Scores credibility
→ Produces: workplan.json
↓
CONTRADICTION DETECTOR AGENT
→ Compares conflicting sources
→ Weighted scoring formula
→ Overrides stale source
→ Produces: contradiction_report.json
↓
ACTION CHAIN AGENT
→ Executes 5-step chain
→ Handles API failure
→ Recovers via backup supplier
→ Produces: action_chain_log.json
↓
SUMMARY AGENT
→ Aggregates all results
→ Before vs after state
→ Produces: action_chain_summary.json
↓
FLUTTER APP (Mobile/Web)
→ Visualizes full pipeline
→ 4 interactive screens

### Tech Stack
| Component | Technology |
|---|---|
| Agent Orchestration | Google Antigravity |
| LLM Reasoning | Gemini 3.1 Pro (High) |
| Mobile/Web App | Flutter (Dart) |
| Data Formats | CSV, JSON, TXT |
| Platform | Windows / Android / Web |

---

## 3. INPUT SOURCES

| File | Type | Key Signal | Date | Credibility |
|---|---|---|---|---|
| warehouse_sheet.csv | Structured CSV | Stock levels — 3 SKUs critical | 2026-05-07 | 2.8/10 STALE |
| supplier_email.txt | Unstructured text | Al-Noor Traders delayed 5-7 days | 2026-05-13 | 9.6/10 |
| sales_dashboard.json | Semi-structured JSON | 40% sales spike Rice + Oil | 2026-05-13 | 10.0/10 |
| customer_complaints.txt | Unstructured text | 3 complaints out-of-stock | 2026-05-12/13 | 8.6/10 |
| news_article.txt | Unstructured text | M-9 motorway transport strike | 2026-05-13 | 9.2/10 |

---

## 4. GOOGLE ANTIGRAVITY ROLE

Google Antigravity was the CORE orchestration platform 
for this entire project. It was NOT used superficially.

### How Antigravity Was Used:
- **Agent Manager**: Spawned 4 distinct agents with 
  separate roles, contexts, and output responsibilities
- **Multi-agent coordination**: Each agent read outputs 
  from the previous agent, creating a real pipeline
- **Artifact generation**: Every agent produced 
  structured artifacts (JSON + TXT) saved to /logs
- **Reasoning traces**: All decision steps, credibility 
  calculations, and resolution logic are visible in 
  agent outputs
- **Tool execution**: File read/write operations, 
  data analysis, and notification generation all 
  executed within Antigravity workspace
- **Failure simulation**: Step 3 API failure and 
  recovery logic orchestrated through agent reasoning

### Antigravity Artifacts Produced:
1. workplan.json — Planner Agent output
2. workplan_summary.txt — Human readable plan
3. contradiction_report.json — Detector Agent output
4. contradiction_report.txt — Weighted scoring proof
5. action_chain_log.json — Full execution log
6. procurement_notification.txt — Simulated alert
7. emergency_order.txt — Simulated order confirmation
8. customer_notification.txt — Customer update
9. monitoring_schedule.json — 7-day monitoring plan
10. action_chain_summary.json — Final summary

---

## 5. AGENTIC WORKFLOW
Step 1: INGEST
→ 5 sources loaded simultaneously
→ Types: CSV, JSON, TXT x3
Step 2: ANALYZE
→ Planner Agent extracts signals
→ Credibility scored per source
→ Risk level determined: HIGH
Step 3: DETECT CONTRADICTION
→ warehouse_sheet.csv vs 4 fresh sources
→ Formula: (recency0.6) + (credibility0.4)
→ warehouse score: 2.8 — OVERRIDDEN
→ Resolution confidence: HIGH
Step 4: EXECUTE ACTION CHAIN
→ Step 1: Validate Stock ✅
→ Step 2: Notify Procurement ✅
→ Step 3: Emergency Order ❌ FAILED
→ Step 3: Recovery → Pak-Fresh ✅ RECOVERED
→ Step 4: Update Customers ✅
→ Step 5: Schedule Monitoring ✅
Step 5: REPORT OUTCOME
→ Before vs after state shown
→ Cost: PKR 481,250 (within PKR 500,000 limit)
→ All artifacts saved to /logs

---

## 6. ACTION CHAIN DETAILS

| Step | Action | Status | Latency | Cost PKR |
|---|---|---|---|---|
| 1 | Validate Stock | ✅ SUCCESS | 320ms | 0 |
| 2 | Notify Procurement | ✅ SUCCESS | 180ms | 50 |
| 3 | Emergency Order (Al-Noor) | ❌ FAILED | 30,000ms | 0 |
| 3R | Recovery (Pak-Fresh) | 🔄 RECOVERED | 2,100ms | 481,000 |
| 4 | Update Delivery Estimates | ✅ SUCCESS | 150ms | 200 |
| 5 | Schedule Monitoring | ✅ SUCCESS | 95ms | 0 |

**Budget: PKR 481,250 / PKR 500,000 limit ✅ WITHIN LIMIT**

---

## 7. ROBUSTNESS EVIDENCE

### Failure Scenario Demonstrated:
- **Step 3**: Al-Noor Traders API returned timeout 
  after 30 seconds
- **Detection**: Agent identified connection failure
- **Recovery**: Automatically switched to backup 
  supplier Pak-Fresh Distributors, Hyderabad
- **Result**: Order placed successfully within budget
- **Data integrity**: Maintained throughout failure

### Contradiction Handling:
- warehouse_sheet.csv reported sufficient stock
- 4 newer sources reported critical shortage
- Resolution: Timestamp + credibility weighted scoring
- Stale source overridden with HIGH confidence

### Noise Filtering:
- All 5 sources checked for spam/low credibility
- No noise detected in this scenario
- Framework ready to flag and down-rank if detected

---

## 8. COST AND LATENCY ANALYSIS

### Per-Operation Cost Estimate:
| Operation | Cost |
|---|---|
| Emergency order (PKR) | 481,000 |
| Notifications | 250 |
| API calls (simulated) | 0 |
| **Total** | **481,250** |

### Latency Summary:
| Metric | Value |
|---|---|
| Total pipeline time | 32,845ms |
| Excluding failed step | 2,845ms |
| Avg successful step | 186ms |

### Scaling Discussion:
- **10x scale**: 50 SKUs, 10 warehouses — 
  agent pipeline unchanged, data layer scales
- **100x scale**: Multi-region deployment, 
  parallel agent execution per warehouse cluster
- Antigravity agent spawning handles parallelism 
  natively

---

## 9. BASELINE COMPARISON

| Feature | Simple Summarizer | StockSense PK |
|---|---|---|
| Reads multiple sources | ✅ | ✅ |
| Detects contradictions | ❌ | ✅ |
| Scores source credibility | ❌ | ✅ |
| Takes autonomous action | ❌ | ✅ |
| Handles API failures | ❌ | ✅ |
| Budget constraint checking | ❌ | ✅ |
| Before/after state change | ❌ | ✅ |
| Traceable agent reasoning | ❌ | ✅ |
| Multi-agent pipeline | ❌ | ✅ |

---

## 10. SETUP STEPS

### Run Flutter Web App:
```bash
cd stocksense-pk/app
flutter pub get
flutter run -d chrome
```

### View Agent Logs:
All Antigravity artifacts are in /logs folder.
10 files covering full pipeline execution.

### Requirements:
- Flutter SDK 3.0+
- Chrome browser
- Google Antigravity (for agent re-execution)

---

## 11. ASSUMPTIONS

- All data is synthetic and clearly labeled
- PKR 500,000 emergency budget limit assumed
- Supplier API failure rate ~10% assumed realistic
- 2-day delivery from backup supplier assumed
- M-9 motorway disruption affects Karachi region only

---

## 12. LIMITATIONS

1. Currently uses hardcoded mock data — 
   real deployment needs live API integrations
2. Single region (Karachi) — 
   multi-city expansion needed for scale
3. Supplier API simulation only — 
   real supplier APIs would need OAuth integration
4. Monitoring schedule is simulated — 
   real cron job implementation needed for production

---

## 13. PRIVACY NOTE

All data used in this project is completely synthetic.
No real personal information, business data, supplier 
details, or customer data was used anywhere.
All synthetic data is clearly labeled with:
"SYNTHETIC MOCK DATA — AI Seekho 2026 Hackathon"

---

*Built with Google Antigravity | AI Seekho 2026 Hackathon*
*Challenge 1: Autonomous Content-to-Action Agent*

---
