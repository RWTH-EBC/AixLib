within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OPH_6_Floor
  extends ZoneBaseRecord(
    n = 5,
    aowo = 0.7,
    Heater_on = true,
    Cooler_on = false,
    l_cooler = 0,
    RatioConvectiveHeatLighting = 0.5,
    zoneID = "OPH_6_Floor",
    usage = "Floor",
    RoomArea = 837.0,
    Vair = 3348.0,
    alphaiwi = 2.44285714286,
    alphaowi = 2.19090524535,
    alphaowo = 25.0,
    g = 0.78,
    NrPeople = 0.0,
    NrPeopleMachines = 0.0,
    LightingPower = 7.0,
    h_heater = 83700,
    gsunblind = {1.0, 1.0, 1.0, 1.0, 1},
    Aw = {54.2, 9.5, 54.2, 9.5, 0},
    withWindows = true,
    weightfactorswindow = {0.137370148227, 0.0240777935084, 0.137370148227, 0.0240777935084, 0},
    weightfactorswall = {0.129282430627, 0.0227508187976, 0.129282430627, 0.0227508187976, 0.118673301671},
    weightfactorground = 0.254364316008,
    Ai = 4882.5,
    withInnerwalls = true,
    R1i = 1.53660776816e-05,
    C1i = 853573678.665,
    Ao = 945.6,
    withOuterwalls = true,
    R1o = 2.83025896746e-05,
    RRest = 0.000762070069282,
    C1o = 246320566.661);
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &QUOT;Floor&QUOT; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
end OPH_6_Floor;
