within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Temperature T_pool
    "Set water temperature of swimming pool";
  parameter Modelica.Units.SI.Volume V_pool "Volume of pool water";
  parameter Modelica.Units.SI.Area A_pool(min=0)
    "Area of water surface of swimming pool";
  parameter Modelica.Units.SI.Length d_pool(min=0)
    "Average depth of swimming pool";
  parameter Modelica.Units.SI.Volume V_storage
    "Usable Volume of water storage, DIN 19643-1";

  // parameter for pool water circulation
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal(min=0.001)
    "Circulation volume flow rate";
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_partial(min=0)
    "In the case of partial load: circulation volume flow rate during non-opening hours, DIN 19643-1";
  parameter Boolean use_partialLoad=false  "Partial load operation implemented for non opening hours?";
  parameter Boolean use_idealHeater=true "Include an ideal heat exchanger into the circulation system";
  parameter Modelica.Units.SI.PressureDifference dpHeatExchangerPool
    "Pressure drop of heat exchanger, should be zero for an indeal heated pool";

  // parameter for evaporation
  parameter Real beta_inUse(unit="m/s") "Water transfer coefficient during opening hours if pool is used, VDI 2089";
  parameter Boolean use_poolCover=false "Pool covered during non opening hours";

  // parameter for fresh water
  parameter Boolean use_waterRecycling= false "Recycled water used for refilling pool water?";
  parameter Real x_recycling(min=0) "Percentage of refilling water provided by recycled  pool water, DIN 19643-1: <= 0,8";
  parameter Modelica.Units.SI.MassFlowRate m_flow_out(min=0.0001)
    "Waterexchange due to people in the pool, DIN 19643-1";
  parameter Boolean use_HRS=false "Is a heat recovery system physically integrated?";
  parameter Modelica.Units.SI.Efficiency efficiencyHRS
    "Effieciency of heat recovery system";

 // Wave mode
  parameter Boolean use_wavePool=false "Is there a wave machine installed?";
  parameter Modelica.Units.SI.Length h_wave "Height of generatedwave";
  parameter Modelica.Units.SI.Length w_wave
    "Width of generated wave/ width of wave machine outlet";
  parameter Modelica.Units.SI.Time wavePool_startTime
    "Start time of first wave cycle";
  parameter Modelica.Units.SI.Time wavePool_period "Time of cycling period";
  parameter Real wavePool_width "Length of wave generation within cycling period";

 // Pool Walls
  parameter Modelica.Units.SI.Area AInnerPoolWall;
  parameter Modelica.Units.SI.Area APoolWallWithEarthContact;
  parameter Modelica.Units.SI.Area APoolFloorWithEarthContact;
  parameter Modelica.Units.SI.Area AInnerPoolFloor;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterHorizontal;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterVertical;
  //replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition PoolWallParam;
  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition
    PoolWallParam constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition
    annotation (choicesAllMatching=true, Placement(transformation(extent={{48,-98},{68,-78}})));

  annotation (Documentation(info="<html>

  This is the base definition of indoor swimming pool records used in <a href=
  \"AixLib.Fluid.Pools.IndoorSwimmingPool\">AixLib.Fluid.Pools.IndoorSwimmingPool</a>.
  It aggregates all parameters at one record to enhance usability,
  exchanging entire datasets and automatic generation of these
  datasets.
<h4>References </h4>
<ul>
<li>German Association of Engineers: Guideline VDI 2089-1, January 2010: Building Services in swimming baths - Indoor Pools</li>
<li>German Institute for Standardization DIN 19643-1, November 2012: Treatment of water of swimming pools and baths - Part 1 General Requirements</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
end IndoorSwimmingPoolBaseRecord;
