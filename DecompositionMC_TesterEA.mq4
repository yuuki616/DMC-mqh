//+------------------------------------------------------------------+
//| DecompositionMC_TesterEA.mq4 – 18 ステップ検証                   |
//+------------------------------------------------------------------+
#property strict
#include <DecompositionMonteCarloMM.mqh>

input string Pattern="W,W,W,W,W,L,L,L,L,W,L,L,W,L,L,W,W,W";
input int    Trades =18;

CDecompMC mm; double pnl=0;

int OnInit(){
   mm.Init(); string tok[]; int p=StringSplit(Pattern,',',tok);

   for(int i=0;i<Trades;i++){
      bool win=(StringFind(tok[i%p],"W",0)>=0);
      mm.OnTrade(win);
      double lot=mm.NextLot();
      pnl += win?lot:-lot;
      PrintFormat("Step %02d  %s  Seq=[%s]  Stock=%d  NextLot=%.0f  CumPnL=%+.0f",
                  i+1,win?"WIN ":"LOSE",mm.Seq(),mm.Stock(),lot,pnl);
   }
   ExpertRemove(); return INIT_SUCCEEDED;
}
void OnTick(){}
