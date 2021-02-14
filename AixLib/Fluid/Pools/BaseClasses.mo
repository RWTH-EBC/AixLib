within AixLib.Fluid.Pools;
package BaseClasses "Base classes for Swimming Pool Models"
  model HeatTransferWaterSurface
    "Model for heattransfer at the water surface"

    constant Modelica.SIunits.Area A "Area of pool";

      //Cover specs
    constant Modelica.SIunits.ThermalConductance R_poolCover= lambda_poolCover *A/t_poolCover "Thermal resistance of the pool cover";
    constant Modelica.SIunits.ThermalConductivity lambda_poolCover "Thermal Conductivity of the pool cover";
    constant Modelica.SIunits.Length t_poolCover "Thickness of the pool cover";
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air "Coefficient of heat transfer between the water surface and the room air";
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Cover "Coefficient of heat transfer between the water and the pool cover";

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_Cover
      "Heatport if there is a cover during non-openin hours"
      annotation (Placement(transformation(extent={{-56,-70},{-36,-50}}),
          iconTransformation(extent={{-56,-70},{-36,-50}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_noCover
      "Heatport if there isn't a cover during non-opening hours"
      annotation (Placement(transformation(extent={{42,-68},{62,-48}}),
          iconTransformation(extent={{42,-68},{62,-48}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort_b
      "Connect to TRoom"
      annotation (Placement(transformation(extent={{-12,54},{8,74}}),
          iconTransformation(extent={{-12,54},{8,74}})));
    Modelica.Thermal.HeatTransfer.Components.Convection CoverAir
      "Heat transfer between the cover surface and the air" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-44,36})));
    Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor WaterCover
      "Convection between the pool water and the pool cover" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-46,-26})));
    Modelica.Blocks.Sources.Constant CoefficientOfHeatTransferAir(k=alpha_Air)
      "Coefficient of heat transfer between water surface and room air"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-8,22})));
    Modelica.Thermal.HeatTransfer.Components.Convection WaterAir
      "Convection at the watersurface" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={46,8})));
    Modelica.Blocks.Sources.Constant CoefficientOfHeatTransferWater(k=alpha_Cover)
      "Coefficient of heat transfer between water surface and the pool cover"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-2,-26})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
          R_poolCover) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-46,4})));
  equation

    connect(WaterCover.fluid, heatport_Cover)
      annotation (Line(points={{-46,-36},{-46,-60}},           color={191,0,0}));
    connect(CoefficientOfHeatTransferAir.y, WaterAir.Gc) annotation (Line(points={{-8,33},
            {70,33},{70,8},{56,8}},              color={0,0,127}));
    connect(WaterAir.solid, heatport_noCover) annotation (Line(points={{46,-2},
            {48,-2},{48,-58},{52,-58}},
                                     color={191,0,0}));
    connect(WaterAir.fluid, heatPort_b) annotation (Line(points={{46,18},{24,18},
            {24,42},{-2,42},{-2,64}},  color={191,0,0}));
    connect(CoefficientOfHeatTransferAir.y, CoverAir.Gc) annotation (Line(points={{-8,33},
            {-6,33},{-6,32},{-34,32},{-34,36}},         color={0,0,127}));
    connect(CoefficientOfHeatTransferWater.y, WaterCover.Rc)
      annotation (Line(points={{-13,-26},{-36,-26}},           color={0,0,127}));
    connect(thermalConductor.port_a, WaterCover.solid)
      annotation (Line(points={{-46,-6},{-46,-16}},  color={191,0,0}));
    connect(thermalConductor.port_b, CoverAir.solid) annotation (Line(points={{-46,14},
            {-46,20},{-44,20},{-44,26}},        color={191,0,0}));
    connect(CoverAir.fluid, heatPort_b)
      annotation (Line(points={{-44,46},{-2,46},{-2,64}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -60},{100,60}}), graphics={
          Rectangle(
            extent={{-84,-4},{-14,-16}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-84,8},{-14,-4}},
            lineColor={28,108,200},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Text(
            extent={{-28,26},{24,28}},
            lineColor={0,0,0},
            fontSize=22,
            textString="OR"),
          Rectangle(
            extent={{-54,16},{-46,-36}},
            lineColor={238,46,47},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,16},{-40,16},{-50,26},{-60,16}},
            lineColor={238,46,47},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{10,-4},{80,-16}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{42,16},{50,-36}},
            lineColor={238,46,47},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-100,60},{100,-60}}, lineColor={0,0,0}),
          Polygon(
            points={{36,16},{56,16},{46,26},{36,16}},
            lineColor={238,46,47},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{100,
              60}})));
  end HeatTransferWaterSurface;

  model HeatTransferConduction
    "Heat transfer due to conduction through pool walls"
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W "Coefficient of heat transfer between the water and the pool walls";
    constant Modelica.SIunits.Temperature T_nextDoor "Temperature of room bordering the pool walls";
    parameter Boolean NextToSoil;

    parameter Integer nExt(min = 1) "Number of RC-elements of exterior walls"
      annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.ThermalResistance RExt[nExt](
      each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b"
      annotation(Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.ThermalResistance RExtRem(
      min=Modelica.Constants.small) "Resistance of remaining resistor RExtRem between capacitor n and port_b"
       annotation(Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.HeatCapacity CExt[nExt](
      each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b"
      annotation(Dialog(group="Thermal mass"));

    Modelica.Thermal.HeatTransfer.Components.Convection Convection
      "Convection between Water and pool wall/ground"
      annotation (Placement(transformation(extent={{-32,-6},{-46,8}})));
    ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall extWalRC(
      final RExt=RExt,
      final RExtRem=RExtRem,
      final CExt=CExt,
      final n=nExt)
      "Surounding Walls of Swimming Pool"
      annotation (Placement(transformation(extent={{-20,-6},{-6,8}})));
    Modelica.Blocks.Logical.Switch switch1 "Neighbouring Soil or different rooms"
      annotation (Placement(transformation(extent={{34,-6},{22,6}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature1 annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={8,-8.88178e-16})));
    Modelica.Blocks.Sources.Constant TNextDoor(k=T_nextDoor)
      "Temperature of the room beneath the pool"
      annotation (Placement(transformation(extent={{74,-28},{66,-20}})));
    Modelica.Blocks.Sources.BooleanConstant booleanNextToSoil(k=NextToSoil)
      "Soil or room under the Swimming Pool"
      annotation (Placement(transformation(extent={{64,-6},{52,6}})));
    Modelica.Blocks.Sources.Constant Constant_alpha_W(k=alpha_W)
      "heat transfer coefficient between wall and water"
      annotation (Placement(transformation(extent={{-20,36},{-30,46}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_a
      "Inlet for heattransfer"
      annotation (Placement(transformation(extent={{-110,-8},{-90,12}})));
    Modelica.Blocks.Interfaces.RealInput TSoil "Temperature of Soil"
      annotation (Placement(transformation(extent={{126,16},{86,56}})));
  equation
    connect(extWalRC.port_a,Convection. solid)
      annotation (Line(points={{-20,0.363636},{-20,1},{-32,1}},
                                                              color={191,0,0}));
    connect(extWalRC.port_b,prescribedTemperature1. port) annotation (Line(points={{-6,
            0.363636},{2,0.363636},{2,-2.22045e-16}},
                                                color={191,0,0}));
    connect(switch1.u1, TSoil) annotation (Line(points={{35.2,4.8},{35.2,36},{106,
            36}}, color={0,0,127}));
    connect(TNextDoor.y,switch1. u3)
      annotation (Line(points={{65.6,-24},{35.2,-24},{35.2,-4.8}},
                                                               color={0,0,127}));
    connect(switch1.y,prescribedTemperature1. T) annotation (Line(points={{21.4,0},
            {22,0},{22,-1.77636e-15},{15.2,-1.77636e-15}},
                                      color={0,0,127}));
    connect(booleanNextToSoil.y,switch1. u2) annotation (Line(points={{51.4,0},{35.2,
            0}},                    color={255,0,255}));
    connect(Constant_alpha_W.y,Convection. Gc)
      annotation (Line(points={{-30.5,41},{-39,41},{-39,8}},
                                                           color={0,0,127}));
    connect(Convection.fluid,heatport_a)  annotation (Line(points={{-46,1},{-64,1},
            {-64,2},{-100,2}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-80,58},{28,-26}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{28,68},{48,-46}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-86,-26},{30,-46}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Forward),
          Polygon(
            points={{-16,-10},{-4,6},{58,-52},{46,-62},{-16,-10}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{32,-68},{36,-66},{62,-38},{76,-78},{32,-68}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HeatTransferConduction;
end BaseClasses;
