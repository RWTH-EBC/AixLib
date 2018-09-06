within AixLib.ThermalZones.HighOrder.House.MFD.BuildingAndEnergySystem;
model OneAppartment_Radiators
  "just one appartment (same appartment as in MFD, but hydraulic network fit to this one appartment)"
  import HouseModels = AixLib.ThermalZones.HighOrder;
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(group = "Medium"), choicesAllMatching = true);
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0)
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  HouseModels.House.MFD.EnergySystem.OneAppartment.Radiators Hydraulic(
    hydResRadLi(m_flow_nominal=0.0001),
    hydResRadBe(m_flow_nominal=0.0001),
    hydResRadCh(m_flow_nominal=0.0001),
    hydResRadBa(m_flow_nominal=0.0001),
    hydResInflow(m_flow_nominal=0.0001),
    hydResRadKi(m_flow_nominal=0.0001))                                annotation(Placement(transformation(extent = {{-22, -72}, {38, -12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow6(Q_flow = 0) annotation(Placement(transformation(extent = {{-62, 26}, {-50, 32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow = 0) annotation(Placement(transformation(extent = {{-78, 62}, {-66, 68}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow = 0) annotation(Placement(transformation(extent = {{-78, 26}, {-66, 32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(Q_flow = 0) annotation(Placement(transformation(extent = {{-78, 46}, {-66, 52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow4(Q_flow = 0) annotation(Placement(transformation(extent = {{-62, 38}, {-50, 44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow5(Q_flow = 0) annotation(Placement(transformation(extent = {{-64, 52}, {-52, 58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow8(Q_flow = 0) annotation(Placement(transformation(extent = {{76, 18}, {64, 24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow9(Q_flow = 0) annotation(Placement(transformation(extent = {{-80, 14}, {-68, 20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow10(Q_flow = 0) annotation(Placement(transformation(extent = {{-60, 18}, {-48, 24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow7(Q_flow = 0) annotation(Placement(transformation(extent = {{78, 38}, {66, 44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow11(Q_flow = 0) annotation(Placement(transformation(extent = {{72, 60}, {60, 66}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow12(Q_flow = 0) annotation(Placement(transformation(extent = {{58, 40}, {46, 46}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow13(Q_flow = 0) annotation(Placement(transformation(extent = {{60, 18}, {48, 24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow14(Q_flow = 0) annotation(Placement(transformation(extent = {{60, 28}, {48, 34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow15(Q_flow = 0) annotation(Placement(transformation(extent = {{74, 28}, {62, 34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow16(Q_flow = 0) annotation(Placement(transformation(extent = {{74, 50}, {62, 56}})));
  Modelica.Fluid.Interfaces.FluidPort_a
                         Inflow(redeclare package Medium = Medium)
    "Inflow to connect with external models (boiler, pump etc.)"                             annotation(Placement(transformation(extent = {{-26, -118}, {-6, -98}}), iconTransformation(extent = {{-26, -118}, {-6, -98}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                         Returnflow(redeclare package Medium = Medium)
    "Returnflow to connect with external models (boiler, pump etc.)"                                 annotation(Placement(transformation(extent = {{-2, -118}, {18, -98}}), iconTransformation(extent = {{-2, -118}, {18, -98}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {-32, 112}), iconTransformation(extent = {{-15, -15}, {15, 15}}, rotation = -90, origin = {-31, 105})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort_Window[5] annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {20, 112}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = -90, origin = {26, 106})));
  Utilities.Interfaces.SolarRad_in SolarRadiation[2] "[SE, NW]" annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {58, 108})));
  HouseModels.House.MFD.BuildingEnvelope.OneAppartment_VoWo Appartment(
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    Floor=2,
    Livingroom(
      T0_air=293.15,
      T0_OW=293.15,
      T0_IWChild=293.15,
      T0_IWBedroom=293.15,
      T0_IWNeighbour=293.15,
      T0_CE=293.35,
      T0_FL=292.95),
    Children(
      T0_air=293.15,
      T0_OW=293.15,
      T0_IWLivingroom=293.15,
      T0_IWNeighbour=293.15,
      T0_CE=293.35,
      T0_FL=292.95),
    Bedroom(
      T0_air=293.15,
      T0_OW=293.15,
      T0_IWLivingroom=293.15,
      T0_IWNeighbour=293.15,
      T0_CE=293.35,
      T0_FL=292.95),
    Bathroom(
      T0_IWKitchen=293.15,
      T0_IWBedroom=293.15,
      T0_OW=293.15,
      T0_CE=297.35,
      T0_FL=296.95),
    Kitchen(
      T0_air=293.15,
      T0_OW=293.15,
      T0_CE=293.35,
      T0_FL=292.95),
    Corridor(
      T0_IWKitchen=293.15,
      T0_IWBedroom=293.15,
      T0_IWLivingroom=293.15,
      T0_IWChild=293.15,
      T0_CE=293.35,
      T0_FL=292.95))
    annotation (Placement(transformation(extent={{-30,8},{32,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside3 annotation(Placement(transformation(extent = {{-48, 78}, {-67.5, 96}})));
  Modelica.Blocks.Interfaces.RealInput air_temp annotation(Placement(transformation(extent = {{20, -20}, {-20, 20}}, rotation = 90, origin = {-80, 112}), iconTransformation(extent = {{14, -14}, {-14, 14}}, rotation = 90, origin = {-86, 106})));
  Modelica.Blocks.Interfaces.RealInput TSet[5] "1 - Livingroom
   2- Bedroom
   3 - Children
   4 - Bath
   5 - Kitchen" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-120, -14}, {-90, 16}})));
equation
  connect(Appartment.WindSpeedPort, WindSpeedPort) annotation(Line(points={{
          -6.85333,61.7333},{-6.85333,80},{-32,80},{-32,112}},                                                                            color = {0, 0, 127}));
  connect(Appartment.thermNeighbour_Livingroom, fixedHeatFlow1.port) annotation(Line(points={{
          -21.7333,57.6},{-38,57.6},{-38,65},{-66,65}},                                                                                              color = {191, 0, 0}));
  connect(Appartment.thermNeigbour_Bedroom, fixedHeatFlow5.port) annotation(Line(points={{
          -21.7333,52.64},{-38,52.64},{-38,55},{-52,55}},                                                                                          color = {191, 0, 0}));
  connect(Appartment.thermCeiling_Livingroom, fixedHeatFlow3.port) annotation(Line(points={{
          -21.7333,46.8533},{-38,46.8533},{-38,49},{-66,49}},                                                                                            color = {191, 0, 0}));
  connect(Appartment.thermFloor_Livingroom, fixedHeatFlow4.port) annotation(Line(points={{
          -21.7333,41.8933},{-38,41.8933},{-38,41},{-50,41}},                                                                                          color = {191, 0, 0}));
  connect(Appartment.thermCeiling_Bath, fixedHeatFlow10.port) annotation(Line(points={{
          -21.7333,26.1867},{-38,26.1867},{-38,21},{-48,21}},                                                                                       color = {191, 0, 0}));
  connect(Appartment.thermFloor_Bath, fixedHeatFlow9.port) annotation(Line(points={{
          -21.7333,20.4},{-38,20.4},{-38,17},{-68,17}},                                                                                    color = {191, 0, 0}));
  connect(Appartment.thermNeighbour_Child, fixedHeatFlow11.port) annotation(Line(points={{23.7333,
          57.6},{38,57.6},{38,63},{60,63}},                                                                                                  color = {191, 0, 0}));
  connect(Appartment.thermStaircase, fixedHeatFlow16.port) annotation(Line(points={{23.7333,
          52.2267},{38,52.2267},{38,53},{62,53}},                                                                                            color = {191, 0, 0}));
  connect(Appartment.thermCeiling_Children, fixedHeatFlow12.port) annotation(Line(points={{23.7333,
          46.44},{38,46.44},{38,43},{46,43}},                                                                                                   color = {191, 0, 0}));
  connect(Appartment.thermCeiling_Corridor, fixedHeatFlow14.port) annotation(Line(points={{23.7333,
          36.52},{38,36.52},{38,31},{48,31}},                                                                                                   color = {191, 0, 0}));
  connect(Appartment.thermCeiling_Kitchen, fixedHeatFlow13.port) annotation(Line(points={{23.7333,
          26.1867},{38,26.1867},{38,21},{48,21}},                                                                                                  color = {191, 0, 0}));
  connect(Appartment.SolarRadiation_SE, SolarRadiation[1]) annotation(Line(points={{6.78667,
          61.7333},{6.78667,72},{58,72},{58,113}},                                                                                            color = {255, 128, 0}));
  connect(Appartment.SolarRadiation_NW, SolarRadiation[2]) annotation(Line(points={{12.9867,
          61.7333},{12.9867,72},{58,72},{58,103}},                                                                                            color = {255, 128, 0}));
  connect(fixedHeatFlow7.port, Appartment.thermFloor_Children) annotation(Line(points={{66,41},
          {64,41},{64,38},{38,38},{38,41.48},{23.7333,41.48}},                                                                                                   color = {191, 0, 0}));
  connect(fixedHeatFlow8.port, Appartment.thermFloor_Kitchen) annotation(Line(points={{64,21},
          {62,21},{62,16},{38,16},{38,21.2267},{23.7333,21.2267}},                                                                                                  color = {191, 0, 0}));
  connect(fixedHeatFlow15.port, Appartment.thermFloor_Corridor) annotation(Line(points={{62,31},
          {60,31},{60,26},{38,26},{38,31.56},{23.7333,31.56}},                                                                                                    color = {191, 0, 0}));
  connect(fixedHeatFlow6.port, Appartment.thermCeiling_Bedroom) annotation(Line(points={{-50,29},
          {-38,29},{-38,36.52},{-21.7333,36.52}},                                                                                                 color = {191, 0, 0}));
  connect(fixedHeatFlow2.port, Appartment.thermFloor_Bedroom) annotation(Line(points={{-66,29},
          {-62,29},{-62,26},{-38,26},{-38,31.56},{-21.7333,31.56}},                                                                                                   color = {191, 0, 0}));
  connect(tempOutside3.T, air_temp) annotation(Line(points = {{-46.05, 87}, {-46.05, 112}, {-80, 112}}, color = {0, 0, 127}));
  connect(AirExchangePort_Window, Appartment.AirExchangePort) annotation(Line(points={{20,112},
          {20,80},{0.173333,80},{0.173333,61.7333}},                                                                                               color = {0, 0, 127}));
  connect(tempOutside3.port, Appartment.thermOutside) annotation(Line(points={{-67.5,
          87},{-80,87},{-80,74},{-13.88,74},{-13.88,61.7333}},                                                                                       color = {191, 0, 0}));
  connect(Inflow, Hydraulic.FLOW) annotation(Line(points={{-16,-108},{20,-108},
          {20,-73.1429},{28.4,-73.1429}},                                                                               color = {0, 127, 255}));
  connect(Returnflow, Hydraulic.RETURN) annotation(Line(points={{8,-108},{8,-74},
          {23.2,-74},{23.2,-73.1429}},                                                                                 color = {0, 127, 255}));
  connect(Hydraulic.radLi, Appartment.StarLivingroom) annotation(Line(points={{-20,
          -30.1429},{-26,-30.1429},{-26,-30},{-34,-30},{-34,0},{-5.61333,0},{
          -5.61333,40.4467}},                                                                                                    color = {0, 0, 0}));
  connect(Hydraulic.convLi, Appartment.thermLivingroom) annotation(Line(points={{-19.9,
          -34.4286},{-34,-34.4286},{-34,0},{-6,0},{-6,43.34},{-9.33333,43.34}},                                                                                                   color = {191, 0, 0}));
  connect(Hydraulic.radBe, Appartment.StarBedroom) annotation(Line(points={{35.4,
          -15.7143},{54,-15.7143},{54,0},{-5.61333,0},{-5.61333,36.7267}},                                                                                         color = {0, 0, 0}));
  connect(Hydraulic.convBe, Appartment.ThermBedroom) annotation(Line(points={{35.6,
          -22.5714},{54,-22.5714},{54,0},{-9.74667,0},{-9.74667,36.52}},                                                                                          color = {191, 0, 0}));
  connect(Hydraulic.radCh, Appartment.StarChildren) annotation(Line(points={{36,
          -29.4286},{54,-29.4286},{54,0},{14.64,0},{14.64,45.6133}},                                                                                         color = {0, 0, 0}));
  connect(Hydraulic.convCh, Appartment.ThermChildren) annotation(Line(points={{35.7,
          -36.1429},{54,-36.1429},{54,0},{12,0},{12,22},{9.68,22},{9.68,46.44}},                                        color = {191, 0, 0}));
  connect(Hydraulic.radBa, Appartment.StarBath) annotation(Line(points={{35.6,
          -51.4286},{54,-51.4286},{54,0},{2.44667,0},{2.44667,34.8667}},                                                                                   color = {0, 0, 0}));
  connect(Hydraulic.convBa, Appartment.ThermBath) annotation(Line(points={{35.7,
          -57.7143},{54,-57.7143},{54,0},{-1.48,0},{-1.48,34.8667}},                                                                                    color = {191, 0, 0}));
  connect(Hydraulic.radKi, Appartment.StarKitchen) annotation(Line(points={{-19.5,
          -55.4286},{-34,-55.4286},{-34,0},{9.88667,0},{9.88667,31.7667}},                                                                                          color = {0, 0, 0}));
  connect(Hydraulic.convKi, Appartment.ThermKitchen) annotation(Line(points={{-19.6,
          -60.1429},{-34,-60.1429},{-34,0},{10.92,0},{10.92,36.52}},                                                                                           color = {191, 0, 0}));
  connect(Hydraulic.TSet, TSet) annotation(Line(points = {{-13.1, -16}, {-14, -16}, {-14, 0}, {-120, 0}}, color = {0, 0, 127}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-120,
            -120},{100,120}}),                                                                           graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for an appartment, considered as a single unit with an energy system based on radiators.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"), Icon(coordinateSystem(extent = {{-120, -120}, {100, 120}}, preserveAspectRatio = false), graphics={  Bitmap(extent = {{-86, 80}, {76, -84}}, fileName = "modelica://AixLib/Resources/Images/Building/HighOrder/MFD_FloorPlan_En.PNG")}));
end OneAppartment_Radiators;
