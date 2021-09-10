within ;
model zweipunktRegler_Pufferspeicher

 parameter Modelica.SIunits.Temperature T_ref=273.15+60 "Solltemperatur";
  parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62
  parameter Boolean use_BufferStorage=false;
  parameter  Modelica.SIunits.TemperatureDifference TDiff_HK=8 "Differenz zwischen Vorlauftemperatur des Kessels und TTop";



  Modelica.Blocks.Logical.OnOffController onOffController(
  bandwidth=bandwidth, pre_y_start=true)
    annotation (Placement(transformation(extent={{-10,24},{10,44}})));

  Modelica.Blocks.Sources.RealExpression T_difference(y=TDiff_HK)
    annotation (Placement(transformation(extent={{-102,54},{-82,74}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_aus
    annotation (Placement(transformation(extent={{90,24},{110,44}})));
  Modelica.Blocks.Interfaces.RealInput T_ein(quantity="ThermodynamicTemperature",unit="K") "Vorlauftemperatur"
    annotation (Placement(transformation(extent={{-120,12},{-80,52}})));
  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    redeclare package Medium = AixLib.Media.Water,
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    useHeatingRod=false,
    redeclare AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data,
    TTop=TTop,
    TBottom=TBottom)
    annotation (Placement(transformation(
        extent={{-15,-19},{15,19}},
        rotation=90,
        origin={21,-57})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package          Medium =
                Medium) if use_BufferStorage
    annotation (Placement(transformation(extent={{-114,-62},{-94,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package          Medium =
                Medium) if use_BufferStorage
    annotation (Placement(transformation(extent={{94,-62},{114,-42}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={21,-29})));



  Modelica.Blocks.Sources.RealExpression TTop(y=TTop)
    annotation (Placement(transformation(extent={{-102,-6},{-82,14}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-58,16},{-38,36}})));
equation
   //BufferStorage

 if (T_ein-TTop)>=TDiff_HK then
   use_BufferStorage=true;


 else
   use_BufferStorage=false;
 end if;

  connect(T_reference.y, onOffController.reference)
    annotation (Line(points={{-81,64},{-62,64},{-62,40},{-12,40}},
                                               color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{11,34},{32,34}},  color={255,0,255}));
  connect(switch1.y, PLR_aus)
    annotation (Line(points={{55,34},{100,34}}, color={0,0,127}));
  connect(realZero.y, switch1.u3) annotation (Line(points={{-81,-20},{26,-20},{26,
          26},{32,26}}, color={0,0,127}));
  connect(PLR_ein, switch1.u1) annotation (Line(points={{-100,90},{24,90},{24,42},
          {32,42}},     color={0,0,127}));

  connect(port_a, bufferStorage.fluidportTop1) annotation (Line(points={{-104,-52},
          {-62,-52},{-62,-62.25},{1.81,-62.25}},        color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, port_b) annotation (Line(points={{40.38,
          -62.0625},{52.19,-62.0625},{52.19,-52},{104,-52}},      color={0,127,
          255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
      Line(points={{21,-36},{21,-42.375},{19.86,-42.375}},color={191,0,0}));
  connect(T_ein, add.u1)
    annotation (Line(points={{-100,32},{-60,32}}, color={0,0,127}));
  connect(TTop.y, add.u2) annotation (Line(points={{-81,4},{-72,4},{-72,20},{-60,
          20}}, color={0,0,127}));
  connect(add.y, onOffController.u) annotation (Line(points={{-37,26},{-24,26},{
          -24,28},{-12,28}}, color={0,0,127}));
  annotation (uses(AixLib(version="1.0.0"), Modelica(version="3.2.3")));
end zweipunktRegler_Pufferspeicher;
