within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Temperature TPool
    "Set water temperature of swimming pool";
  parameter Modelica.Units.SI.Volume VPool "Volume of pool water";
  parameter Modelica.Units.SI.Area APool(min=0)
    "Area of water surface of swimming pool";
  parameter Modelica.Units.SI.Length depthPool(min=0)
    "Average depth of swimming pool";
  parameter Modelica.Units.SI.Volume VStorage
    "Usable Volume of water storage, DIN 19643-1";

  // parameter for pool water circulation
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal(min=0.001)
    "Circulation volume flow rate";
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_partial(min=0)
    "In the case of partial load: circulation volume flow rate during non-opening hours, DIN 19643-1";
  parameter Boolean use_partialLoad=false  "Partial load operation implemented for non opening hours?";
  parameter Modelica.Units.SI.PressureDifference dpHeaExcPool
    "Pressure drop of heat exchanger, should be zero for an indeal heated pool";
  parameter Boolean use_idealHeater=true "Include an ideal heat exchanger into the circulation system";
  parameter Real KHeat "Gain of controller for ideal heater";
  parameter Modelica.Units.SI.Time THeat "Time constant of Integrator block for ideal heater";
  parameter Real QMaxHeat "Upper limit of output for ideal heater";
  parameter Real QMinHeat "Lower limit of output for ideal heater";

  // parameter for evaporation
  parameter Real betaInUse(unit="m/s") "Water transfer coefficient during opening hours if pool is used, VDI 2089";
  parameter Boolean use_poolCover=false "Pool covered during non opening hours";

  // parameter for fresh water
  parameter Boolean use_waterRecycling= false "Recycled water used for refilling pool water?";
  parameter Real x_recycling(min=0) "Percentage of refilling water provided by recycled  pool water, DIN 19643-1: <= 0,8";
  parameter Modelica.Units.SI.MassFlowRate m_flow_out(min=0.0001)
    "Waterexchange due to people in the pool, DIN 19643-1";
  parameter Boolean use_HRS=false "Is a heat recovery system physically integrated?";
  parameter Modelica.Units.SI.Efficiency etaHRS
    "Effieciency of heat recovery system";

 // Wave mode
  parameter Boolean use_wavePool=false "Is there a wave machine installed?";
  parameter Modelica.Units.SI.Length heightWave "Height of generated wave";
  parameter Modelica.Units.SI.Length widthWave
    "Width of generated wave/ width of wave machineoutlet";
  parameter Modelica.Units.SI.Time timeWavePul_start
    "Start time of first wave cycle";
  parameter Modelica.Units.SI.Time periodeWavePul "Time of cycling period";
  parameter Real widthWavePul "Fraction of time of wave generation within cycling period";

 // Pool Walls
  parameter Modelica.Units.SI.Area AWalInt "Area of pool walls which is connected to inner rooms (inner pool walls)";
  parameter Modelica.Units.SI.Area AWalExt "Area of pool walls which is connected to the ground (pool wall with earth contact)";
  parameter Modelica.Units.SI.Area AFloInt "Area of pool floors which is connected to inner rooms (inner pool floor)";
  parameter Modelica.Units.SI.Area AFloExt "Area of pool floors which is connected to teh ground (pool floor with earth contact)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterHorizontal "Mean value for the heat transfer coefficient of free convection on horizontal pool floors";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterVertical "Mean value for the heat transfer coefficient of free convection on vertical pool walls";
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
