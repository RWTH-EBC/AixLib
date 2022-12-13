within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H05_16 "50/0,5-16 PN 6/10 maximum volume flow 53.0 m^3/h"
  extends AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord(
            maxMinHeight=
            [0, 15.801652892561986, 0.3801652892562011;
2.0580912863070537, 16, 0.3305785123966949;
4.091286307053942, 16, 0.3305785123966949;
6.008298755186722, 16, 0.2809917355371887;
8.04149377593361, 15.950413223140497, 0.23140495867768607;
10.016597510373446, 16, 0.08264462809917461;
12.049792531120332, 15.851239669421489, 0.033057851239671976;
13.966804979253114, 15.454545454545457, 0.18181818181817988;
17.975103734439834, 14.363636363636365, 0.23140495867768607;
21.925311203319502, 13.024793388429753, 0.4297520661157037;
27.90871369294606, 11.041322314049587, 0.8264462809917354;
33.89211618257262, 9.355371900826448, 1.1735537190082646;
41.908713692946066, 6.87603305785124, 1.8677685950413228;
52.713692946058096, 3.0578512396694233, 3.0578512396694233],
            maxMinSpeedCurves=
            [0,3200,500; 53,3200,500],
            nMin=500,
            nMax=3200,
            cHQN=[ 0, 0, 1.31E-06;
                   0, 7.59E-06, 0;
                  -0.00316, 0, 0] "coefficients for H = f(Q,N) from Pump_DN50 (similar scale of max volume flow and maxmin Speed)",
            cPQN=[-4E+01, 2.3E-01, -3.1E-04, 1.27064E-07, -1.27494E-11;
                   0, 0, 3.23573E-06, 0, 0;
                   0, 8.70834E-05, 0, 0, 0;
                  -8.39000E-03, 0, 0, 0, 0] "coefficients for P = f(Q,N) inspired by Pump_DN50 and quick calibration by hand");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">maxMinHeight=[Q [m3/h], Hmax [m], Hmin [m]] (maximum and minimum boundaries of pump)</span></p>
<p><span style=\"font-family: Courier New;\">maxMinSpeedCurves=[Q [m3/h], nMax [rev/min], nMin [rev/min]](maximum and minimum boundaries of pump speed)</span></p>

Data sheet:
<a href=\"https://wilo.com/de/de/Katalog/de/produkte-expertise/wilo-stratos-maxo/stratos-maxo-50-0-5-16-pn-6-10\"
>https://wilo.com/de/de/Katalog/de/produkte-expertise/wilo-stratos-maxo/stratos-maxo-50-0-5-16-pn-6-10</a>
</html>

"));

end Pump_DN50_H05_16;
