within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OPH_4_Restroom
  extends ZoneBaseRecord(
    n = 5,
    aowo = 0.7,
    Heater_on = true,
    Cooler_on = false,
    l_cooler = 0,
    RatioConvectiveHeatLighting = 0.5,
    zoneID = "OPH_4_Restroom",
    usage = "Restroom",
    RoomArea = 134.0,
    Vair = 536.0,
    alphaiwi = 2.38965517241,
    alphaowi = 2.19074074074,
    alphaowo = 25.0,
    g = 0.78,
    NrPeople = 0.0,
    NrPeopleMachines = 0.0,
    LightingPower = 11.1,
    h_heater = 13400,
    gsunblind = {1.0, 1.0, 1.0, 1.0, 1},
    Aw = {8.7, 1.5, 8.7, 1.5, 0},
    withWindows = true,
    weightfactorswindow = {0.13786322498, 0.0237695215482, 0.13786322498, 0.0237695215482, 0},
    weightfactorswall = {0.129261167328, 0.0225783698389, 0.129261167328, 0.0225783698389, 0.11867896908},
    weightfactorground = 0.254376463531,
    Ai = 647.666666667,
    withInnerwalls = true,
    R1i = 0.000112184318096,
    C1i = 126132583.414,
    Ao = 151.2,
    withOuterwalls = true,
    R1o = 0.00017702091729,
    RRest = 0.00476430963748,
    C1o = 39369992.1342,
    withAHU=false,
    minAHU=0,
    maxAHU=8);
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &QUOT;Restroom&QUOT; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
end OPH_4_Restroom;
