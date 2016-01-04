within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OPH_1_Meeting
  extends ZoneBaseRecord(n = 5, aowo = 0.7, Heater_on = true, Cooler_on = false, l_cooler = 0, RatioConvectiveHeatLighting = 0.5, zoneID = "OPH_1_Meeting", usage = "Meeting", RoomArea = 134.0, Vair = 536.0, alphaiwi = 2.27142857143, alphaowi = 2.19074074074, alphaowo = 25.0, g = 0.78, NrPeople = 32.16, NrPeopleMachines = 2.68, LightingPower = 15.9, h_heater = 13400, gsunblind = {1.0, 1.0, 1.0, 1.0, 1}, Aw = {8.7, 1.5, 8.7, 1.5, 0}, withWindows = true, weightfactorswindow = {0.13786322498, 0.0237695215482, 0.13786322498, 0.0237695215482, 0}, weightfactorswall = {0.129261167328, 0.0225783698389, 0.129261167328, 0.0225783698389, 0.11867896908}, weightfactorground = 0.254376463531, Ai = 469.0, withInnerwalls = true, R1i = 0.000141309044786, C1i = 112210241.118, Ao = 151.2, withOuterwalls = true, R1o = 0.00017702091729, RRest = 0.00476430963748, C1o = 39369992.1342, withAHU=true, minAHU=0, maxAHU=12);
  annotation(Documentation(info="<html>
<p>Zone &QUOT;Meeting&QUOT; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </p>
</html>"));
end OPH_1_Meeting;

