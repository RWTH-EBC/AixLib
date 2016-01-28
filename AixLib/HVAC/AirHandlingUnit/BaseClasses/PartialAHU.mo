within AixLib.HVAC.AirHandlingUnit.BaseClasses;
partial model PartialAHU "Defines necessary parameters and connectors"

    // Booleans for possible AHU modes
  inner parameter Boolean heating=true "Heating Function of AHU"
    annotation (Dialog(group="AHU Modes"));
  inner parameter Boolean cooling=true "Cooling Function of AHU"
    annotation (Dialog(group="AHU Modes"));
  inner parameter Boolean dehumidification=if heating and cooling then true
       else false
    "Dehumidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(group="AHU Modes", enable=(heating and cooling)));
  inner parameter Boolean humidification=if heating and cooling then true else false
    "Humidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(group="AHU Modes", enable=(heating and cooling)));

  inner parameter Real BPF_DeHu(
    min=0,
    max=1) = 0.2
    "By-pass factor of cooling coil during dehumidification. Necessary to calculate the real outgoing enthalpy flow of heat exchanger in dehumidification mode taking the surface enthalpy of the cooling coil into account"
    annotation (Dialog(group="Settings AHU Value", enable=(dehumidification
           and cooling and heating)));
  inner parameter Boolean HRS=true
    "Is a HeatRecoverySystem physically integrated in the AHU?"
    annotation (Dialog(group="AHU Modes"), choices(checkBox=true));
  // Efficiency of HRS
  parameter Real efficiencyHRS_enabled(
    min=0,
    max=1) = 0.8 "efficiency of HRS in the AHU modes when HRS is enabled"
    annotation (Dialog(group="Settings AHU Value", enable=HRS));
  parameter Real efficiencyHRS_disabled(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled (in case that a HRS is physically installed in the AHU)"
    annotation (Dialog(group="Settings AHU Value", enable=HRS));

  Modelica.Blocks.Interfaces.RealInput Vflow_in(unit="m3/s") "m3/s"
                                                annotation (Placement(
        transformation(extent={{-112,68},{-84,96}}),  iconTransformation(extent=
           {{-100,8},{-92,16}})));
  Modelica.Blocks.Interfaces.RealInput T_outdoorAir(unit="K", start=288.15) "K"
    annotation (Placement(transformation(extent={{-112,42},{-84,70}}),
        iconTransformation(extent={{-92,2},{-84,10}})));
  Modelica.Blocks.Interfaces.RealInput X_outdoorAir(start=0.007)
    "kg of water/kg of dry air" annotation (Placement(transformation(extent={{-112,22},
            {-84,50}}),     iconTransformation(extent={{-92,-8},{-84,0}})));
  Modelica.Blocks.Interfaces.RealInput T_extractAir(unit="K", start=296.15) "K"
    annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=0,
        origin={98,82}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={84,48})));
  Modelica.Blocks.Interfaces.RealInput phi_extractAir(start=0.8)
    "relativ Humidity [Range: 0...1]" annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=0,
        origin={98,64}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={84,38})));
  Modelica.Blocks.Interfaces.RealOutput phi_supply(start=0.8)
    "relativ Humidity [Range: 0...1]" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={97,49}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={84,24})));
  Modelica.Blocks.Interfaces.RealInput T_supplyAir(unit="K", start=295.15) "K"
    annotation (Placement(transformation(extent={{112,20},{84,48}}),
        iconTransformation(extent={{80,6},{88,14}})));
  Modelica.Blocks.Interfaces.RealInput phi_supplyAir[2](start={0.4,0.6})
    "relativ Humidity [Range: 0...1] (Vector: [1] min, [2] max)" annotation (
      Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=0,
        origin={98,16}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={84,0})));
  Modelica.Blocks.Interfaces.RealOutput QflowC(unit="W", min=0, start=0.01)
    "The absorbed cooling power supplied from a cooling circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-62,-100}),iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-3,-13})));
  Modelica.Blocks.Interfaces.RealOutput QflowH(unit="W", min=0, start=0.01)
    "The absorbed heating power supplied from a heating circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-22,-100}),iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={41,-13})));
  Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", min=0, start=1e-3)
    "The consumed electrical power supplied from the mains [W]" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={18,-100}),iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={63,-13})));
  Modelica.Blocks.Interfaces.RealOutput Vflow_out(unit="m3/s",start=1e-3) "m3/s"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={54,-100}),iconTransformation(extent={{4,-4},{-4,4}}, origin={-96,
            38})));
  annotation (Diagram(coordinateSystem(extent={{-100,-20},{100,60}},
          preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-100,-20},
            {100,60}}, preserveAspectRatio=false), graphics={Text(
          extent={{4,-10},{34,-16}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString=" ")}));
end PartialAHU;
