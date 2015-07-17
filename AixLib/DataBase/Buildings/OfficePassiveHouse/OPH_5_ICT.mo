within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OPH_5_ICT
  extends ZoneBaseRecord(
    n = 5,
    aowo = 0.7,
    Heater_on = true,
    Cooler_on = false,
    l_cooler = 0,
    RatioConvectiveHeatLighting = 0.5,
    zoneID = "OPH_5_ICT",
    usage = "Rechenzentrum",
    RoomArea = 67.0,
    Vair = 268.0,
    alphaiwi = 2.27142857143,
    alphaowi = 2.1907651715,
    alphaowo = 25.0,
    g = 0.78,
    NrPeople = 2.01,
    NrPeopleMachines = 100.5,
    LightingPower = 7.1,
    h_heater = 6700,
    gsunblind = {1.0, 1.0, 1.0, 1.0, 1},
    Aw = {4.3, 0.8, 4.3, 0.8, 0},
    withWindows = true,
    weightfactorswindow = {0.13599329075, 0.0253010773488, 0.13599329075, 0.0253010773488, 0},
    weightfactorswall = {0.129553836404, 0.0225311019833, 0.129553836404, 0.0225311019833, 0.118738126183},
    weightfactorground = 0.254503260845,
    Ai = 234.5,
    withInnerwalls = true,
    R1i = 0.000282618089572,
    C1i = 56105120.5591,
    Ao = 75.8,
    withOuterwalls = true,
    R1o = 0.000353062716991,
    RRest = 0.00950991783473,
    C1o = 19748404.1293);
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"));
end OPH_5_ICT;
