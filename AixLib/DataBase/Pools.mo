within AixLib.DataBase;
package Pools
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

  record IndoorSwimmingPoolDummy
    "This is a dummy record with non-physical parameter values."
    extends IndoorSwimmingPoolBaseRecord(
      T_pool = Modelica.Constants.eps,
      V_pool= Modelica.Constants.inf,
      A_pool = Modelica.Constants.inf,
      d_pool = Modelica.Constants.inf,
      V_storage = Modelica.Constants.inf,
      V_flow_nominal = Modelica.Constants.inf,
      V_flow_partial = Modelica.Constants.inf,
      use_partialLoad = false,
      use_idealHeater = true,
      dpHeatExchangerPool = Modelica.Constants.inf,
      beta_inUse = Modelica.Constants.inf,
      use_poolCover = false,
      use_waterRecycling = false,
      x_recycling = Modelica.Constants.inf,
      m_flow_out = Modelica.Constants.inf,
      use_HRS = false,
      efficiencyHRS = Modelica.Constants.eps,
      use_wavePool = false,
      h_wave = Modelica.Constants.inf,
      w_wave = Modelica.Constants.inf,
      wavePool_period = Modelica.Constants.eps,
      wavePool_startTime = Modelica.Constants.eps,
      wavePool_width = Modelica.Constants.eps,
      AInnerPoolWall = Modelica.Constants.inf,
      APoolWallWithEarthContact = Modelica.Constants.inf,
      APoolFloorWithEarthContact = Modelica.Constants.inf,
      AInnerPoolFloor = Modelica.Constants.inf,
      hConWaterHorizontal = Modelica.Constants.inf,
      hConWaterVertical = Modelica.Constants.inf,
      PoolWallParam= AixLib.DataBase.Pools.SwimmingPoolWall.WallDummy());
    annotation (Documentation(info="<html>
<p>This record is a place holder for zones without swimming pools to avoid error messages.</p>
</html>"));
  end IndoorSwimmingPoolDummy;

  package TypesOfIndoorSwimmingPools
    record SportPool "Pool which is mainly used by sport swimmers"
      extends IndoorSwimmingPoolBaseRecord(
        T_pool=301.15,
        V_pool=942.956,
        A_pool=416.5,
        d_pool=2.2640000000000002,
        V_storage=69.333925940005700,
        V_flow_nominal=0.0856995884773662,
        V_flow_partial=0.023144444444444443,
        use_partialLoad=true,
        use_idealHeater=true,
        dpHeatExchangerPool = 0,
        beta_inUse=0.011111111111111112,
        use_poolCover=false,
        use_waterRecycling=false,
        x_recycling=0.0,
        m_flow_out=0.170038866026520,
        use_HRS=true,
        efficiencyHRS=0.8,
        use_wavePool=false,
        h_wave=0,
        w_wave=0,
        wavePool_period=1800,
        wavePool_startTime=0,
        wavePool_width=10/30*100,
        AInnerPoolWall=21.658,
        APoolWallWithEarthContact=143.32,
        APoolFloorWithEarthContact=559.82,
        AInnerPoolFloor=0.001,
        hConWaterHorizontal=50.0,
        hConWaterVertical=5200.0,
        PoolWallParam=
            AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteIsulationConstruction());

      annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
    end SportPool;

    record ChildrensPool "Pool which is mainly used by children"

      extends IndoorSwimmingPoolBaseRecord(
        T_pool=303.15,
        V_pool=126.8,
        A_pool=125.0,
        d_pool=0.9303008070432868,
        V_storage=69.333925940005700,
        V_flow_nominal=0.028045267489711933,
        V_flow_partial=0.0125,
        use_partialLoad=true,
        use_idealHeater=true,
        dpHeatExchangerPool = 0,
        beta_inUse=0.011111111111111112,
        use_poolCover=false,
        use_waterRecycling=false,
        x_recycling=0.0,
        m_flow_out=0.055645372003397,
        use_HRS=true,
        efficiencyHRS=0.8,
        use_wavePool=false,
        h_wave=0,
        w_wave=0,
        wavePool_period=1800,
        wavePool_startTime=0,
        wavePool_width=0,
        AInnerPoolWall=0.001,
        APoolWallWithEarthContact=156.5,
        APoolFloorWithEarthContact=156.5,
        AInnerPoolFloor=0.001,
        hConWaterHorizontal=50.0,
        hConWaterVertical=5200.0,
        PoolWallParam=
            AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteIsulationConstruction());
    annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
    end ChildrensPool;
  end TypesOfIndoorSwimmingPools;

  package SwimmingPoolWall
    record WallDummy
      extends AixLib.DataBase.Walls.WallBaseDataDefinition(
        n(min=1) = 1 "Number of wall layers",
        d={1} "Thickness of wall layers",
        rho={1} "Density of wall layers",
        lambda={1} "Thermal conductivity of wall layers",
        c={1} "Specific heat capacity of wall layers",
        eps=1 "Emissivity of inner wall surface");
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end WallDummy;

    record ConcreteIsulationConstruction "Concrete pool construction with isolation"
      extends AixLib.DataBase.Walls.WallBaseDataDefinition(
        n(min=1) = 3 "Number of wall layers",
        d={0.05,0.2,0.1} "Thickness of wall layers",
        rho={1940,2330,30} "Density of wall layers",
        lambda={1.4,2.1,0.035} "Thermal conductivity of wall layers",
        c={0.0001,0.001,0.00138} "Specific heat capacity of wall layers",
        eps=0.9 "Emissivity of inner wall surface");
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ConcreteIsulationConstruction;

    record StainlessSteelConstruction
      extends AixLib.DataBase.Walls.WallBaseDataDefinition(
        n(min=1) = 1 "Number of wall layers",
        d={0.05} "Thickness of wall layers",
        rho={7900} "Density of wall layers",
        lambda={15} "Thermal conductivity of wall layers",
        c={500} "Specific heat capacity of wall layers",
        eps=0.9 "Emissivity of inner wall surface");
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end StainlessSteelConstruction;
  end SwimmingPoolWall;
end Pools;
