within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OPH_3_Office
  extends ZoneBaseRecord(
    n = 5,
    aowo = 0.7,
    Heater_on = true,
    Cooler_on = false,
    l_cooler = 0,
    RatioConvectiveHeatLighting = 0.5,
    zoneID = "OPH_3_Office",
    usage = "Gruppenbuero (zwei bis sechs Arbeitsplaetze)",
    RoomArea = 1675.0,
    Vair = 6700.0,
    alphaiwi = 2.27142857143,
    alphaowi = 2.19101669837,
    alphaowo = 25.0,
    g = 0.78,
    NrPeople = 83.75,
    NrPeopleMachines = 117.25,
    LightingPower = 12.5,
    h_heater = 167500,
    gsunblind = {1.0, 1.0, 1.0, 1.0, 1},
    Aw = {108.5, 19.0, 108.5, 19.0, 0},
    withWindows = true,
    weightfactorswindow = {0.137403538825, 0.0240614491951, 0.137403538825, 0.0240614491951, 0},
    weightfactorswall = {0.129284891808, 0.0227804851231, 0.129284891808, 0.0227804851231, 0.11864201466},
    weightfactorground = 0.254297255439,
    Ai = 5862.5,
    withInnerwalls = true,
    R1i = 1.13047235829e-05,
    C1i = 1402628013.98,
    Ao = 1892.4,
    withOuterwalls = true,
    R1o = 1.4142107968e-05,
    RRest = 0.000380773816236,
    C1o = 492976267.489);
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"));
end OPH_3_Office;
