within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers;
model OneVolumeHeatExchanger1

  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare replaceable package Medium1 = AixLib.Media.Water,
    redeclare replaceable package Medium2 = Modelica.Media.R134a.R134a_ph);

  // Parameters describing heat transfer
  //
  parameter Modelica.SIunits.Area APri = 0.5;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpPri = 2000
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));

  parameter Modelica.SIunits.Mass mWal = 0.5;
  parameter Modelica.SIunits.SpecificHeatCapacity cpWal = 485;

  parameter Modelica.SIunits.Area ASec = 0.5;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSec = 200
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));



  Utilities.WallCells.SimpleWallCell simpleWallCell(
    geoCV=geoCV,
    matHX=matHX,
    calBalEqu=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Utilities.FluidCells.SecondaryFluidCell secondaryFluidCell(
    typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.DirectCurrent,
    redeclare package Medium = Medium1,
    geoCV=geoCV)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Utilities.FluidCells.SecondaryFluidCell secondaryFluidCell1(
    typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.DirectCurrent,
    redeclare package Medium = Medium2,
    geoCV=geoCV)
    annotation (Placement(transformation(extent={{-10,-46},{10,-66}})));

  Utilities.Interfaces.ConstantModeCV constantModeCV
    annotation (Placement(transformation(extent={{-56,-48},{-36,-28}})));
  Modelica.Blocks.Sources.Constant const[3](k={1 - 2e-4,1e-4,1e-4})
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  inner replaceable parameter Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (
    choicesAllMatching=true,
    Dialog(tab="General", group="General"),
    Placement(transformation(extent={{-90,20},{-70,40}})));
  inner replaceable parameter Utilities.Properties.MaterialHX matHX
    "Record that contains parameters of the heat exchanger's material properties"
    annotation (
    choicesAllMatching=true,
    Dialog(tab="General", group="General"),
    Placement(transformation(extent={{-90,-8},{-70,12}})));
equation


  connect(port_a2, secondaryFluidCell1.port_a) annotation (Line(points={{100,-60},
          {86,-60},{86,-62},{62,-62},{62,-86},{-32,-86},{-32,-76},{-32,-56},{-10,
          -56}}, color={0,127,255}));
  connect(secondaryFluidCell1.port_b, port_b2) annotation (Line(points={{10,-56},
          {22,-56},{22,-74},{-62,-74},{-62,-60},{-100,-60}}, color={0,127,255}));
  connect(port_a1, secondaryFluidCell.port_a)
    annotation (Line(points={{-100,60},{-56,60},{-10,60}}, color={0,127,255}));
  connect(secondaryFluidCell.port_b, port_b1)
    annotation (Line(points={{10,60},{56,60},{100,60}}, color={0,127,255}));
  connect(secondaryFluidCell.heatPortSC, simpleWallCell.heatPortSCSec)
    annotation (Line(points={{-2.6,50},{-2.6,50},{-2.6,10}}, color={191,0,0}));
  connect(secondaryFluidCell.heatPortTP, simpleWallCell.heatPortTPSec)
    annotation (Line(points={{0,50},{0,50},{0,10}}, color={191,0,0}));
  connect(simpleWallCell.heatPortSHSec, secondaryFluidCell.heatPortSH)
    annotation (Line(points={{2.6,10},{2.6,10},{2.6,50}}, color={191,0,0}));
  connect(secondaryFluidCell.lenInl, simpleWallCell.lenOut)
    annotation (Line(points={{5,50},{5,50},{5,10}}, color={0,0,127}));
  connect(simpleWallCell.heatPortSCPri, secondaryFluidCell1.heatPortSC)
    annotation (Line(points={{-2.6,-10},{-2.6,-10},{-2.6,-46}}, color={191,0,0}));
  connect(secondaryFluidCell1.heatPortTP, simpleWallCell.heatPortTPPri)
    annotation (Line(points={{0,-46},{0,-10}},         color={191,0,0}));
  connect(simpleWallCell.heatPortSHPri, secondaryFluidCell1.heatPortSH)
    annotation (Line(points={{2.6,-10},{2.6,-10},{2.6,-46}}, color={191,0,0}));
  connect(constantModeCV.ModCV, simpleWallCell.modCV)
    annotation (Line(points={{-35.8,-38},{7,-38},{7,-10}}, color={0,0,127}));
  connect(simpleWallCell.lenOut, secondaryFluidCell1.lenInl) annotation (Line(
        points={{5,10},{12,10},{12,16},{12,-46},{5,-46}}, color={0,0,127}));
  connect(const.y, simpleWallCell.lenInl) annotation (Line(points={{-35,-8},{
          -22,-8},{-22,-24},{5,-24},{5,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,80},{100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-100},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,80},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
                             Text(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200},
                textString="Eva")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OneVolumeHeatExchanger1;
