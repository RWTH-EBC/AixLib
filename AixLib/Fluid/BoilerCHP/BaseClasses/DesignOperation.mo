within AixLib.Fluid.BoilerCHP.BaseClasses;
model DesignOperation "Calculation of operation for nominal/design conditions"

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=50000
    "Design thermal capacity"  annotation (Dialog(group="Design"));

  parameter Modelica.Units.SI.Temperature TSup_nominal=273.15 + 80
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TRet_nominal=273.15 + 60
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);
  parameter Modelica.Units.SI.Temperature TAmb=273.15 + 20
    "Ambient temperature for heat losses" annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.ThermalConductance theCon = 0.0465*Q_flow_nominal/
        1000 + 4.9891 "Thermal conductance";
  parameter String filename=ModelicaServices.ExternalReferences.loadResource(
    "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/BaseClasses/GenericBoiler/Boiler_Generic_Characteristic_Chart.sdf")
    "Filename for generic boiler curves" annotation(Dialog(tab="Advanced"));
  final parameter Modelica.Units.SI.HeatFlowRate nomEff = evaluate(
    extTabPEle,
    {TRet_nominal, TSup_nominal - TRet_nominal, 1, 1},
    SDF.Types.InterpolationMethod.Linear,
    SDF.Types.ExtrapolationMethod.Hold)
    "Nominal efficiency";
  final parameter Modelica.Units.SI.HeatFlowRate nomFueDem = (Q_flow_nominal + QLos_flow_nominal) / nomEff
    "Nominal fuel demand";
  final parameter Modelica.Units.SI.HeatFlowRate QLos_flow_nominal = theCon * (TSup_nominal - TAmb)
    "Nominal heat losses";

  final parameter SDF.Types.ExternalNDTable extTabPEle=SDF.Types.ExternalNDTable(
       4,
       SDF.Functions.readTableData(
         filename,
        "/Characteristic chart",
        "-",
        {"K","K","-","-"}));
  Modelica.Blocks.Interfaces.RealOutput nomFueDemOut(quantity="Power", final unit=
        "W") "Nominal fuel demand" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
protected
  function evaluate
    input SDF.Types.ExternalNDTable table;
    input Real[:] params;
    input SDF.Types.InterpolationMethod interpMethod;
    input SDF.Types.ExtrapolationMethod extrapMethod;
    output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation (
      Include="#include <ModelicaNDTable.c>",
      IncludeDirectory="modelica://SDF/Resources/C-Sources");
  end evaluate;
equation
  nomFueDemOut=nomFueDem;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-82,84},{82,-88}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={199,199,199},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,-72},{58,-72}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-72,-72},{-72,58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-72,-72},{20,-12}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{58,-68},{64,-72},{58,-76},{58,-68}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-2},{-5,4}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-73,60},
          rotation=180),
        Polygon(
          points={{16,-10},{22,-10},{20,-16},{16,-10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,74},{44,28}},
          textColor={0,0,0},
          fontName="Arial Black",
          textString="Design
")}),                                                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the nominal fuel power (W) for nominal
  conditions.
</p>
<p>
  The nominal adiabatic efficiency (reference is the higher heating
  value (includes vaporization enthalpy)) comes from the SDF and
  depends on:
</p>
<ul>
  <li>Nominal return temperature (TRet_nominal)
  </li>
  <li>Nominale temperature difference (TSup_nominal-TRet_nominal)
  </li>
  <li>Nominal relative temperature difference (1)
  </li>
  <li>Nominal relative water mass flow (1)
  </li>
</ul>
<p>
  <br/>
  Further assumptions are taken into account for nominal losses:
  Thermal conductance is described by a fit <span style=
  \"font-family: Calibri; color: #595959;\">0.0465 * QNom/1000 +
  4.9891</span> based on manufacturere data at a temperature difference
  of 50 K to ambient
</p>
</html>", revisions="<html><ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end DesignOperation;
