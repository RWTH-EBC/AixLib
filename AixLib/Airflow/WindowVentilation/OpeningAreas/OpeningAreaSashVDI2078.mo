within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashVDI2078
  "Specified VDI 2078: Only valid for bottom-hung inwards opening"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward);
  parameter Modelica.Units.SI.Height heightRevToFrm = 0.1
    "Vertical distance (height) between the reveal above the window and window top frame";
  parameter Modelica.Units.SI.Thickness sWinSas(min=0) = 0
    "Window sash thickness (depth)";
  Modelica.Units.SI.Height effHeight(min=0)
    "Effective height for the thermal updraft";
  Modelica.Units.SI.Height ovlHeight(min=0)
    "Height of the overlap between window frame and casement";
  Real corRev "Correction factor of the window reveal";
equation
  assert(opnAng <= Modelica.Units.Conversions.from_deg(15),
    "The model only applies to a maximum tilt angle of 15°",
    AssertionLevel.warning);
  effHeight = 2/3*(winClrHeight - ovlHeight);
  ovlHeight = if sWinSas > Modelica.Constants.eps then
    sWinSas/(opnWidth + sWinSas)*winClrHeight else 0;
  corRev = if opnWidth <= heightRevToFrm then 1
    else 1 - 0.6*(1 - heightRevToFrm/opnWidth);
  A = if noEvent(opnWidth > Modelica.Constants.eps) then
    ((winClrWidth + winClrHeight - ovlHeight)*opnWidth/3)*corRev else 0;
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="VDI 2078")}),
                                Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to VDI 2078:2015-06.</p>
<p>Only bottom-hung openings can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashVDI2078;
