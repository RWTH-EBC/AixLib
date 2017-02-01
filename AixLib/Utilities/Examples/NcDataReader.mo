within AixLib.Utilities.Examples;
model NcDataReader
  extends Modelica.Icons.Example;
  Sources.NcDataReader NcDataReader_test(
    use_varName=true,
    use_attNameReal=true,
    use_attNameInt=true,
    varName={"temp_year"},
    attNameReal={"float_ex"},
    attNameInt={"Region","TRY"},
    fileName="N:/Forschung/EBC0159_PTJ_DynamischeBewertung_WP_KWK_/Students/pme-fwu/00_Git/AixLib/AixLib/Resources/NcDataReader_ExampleData/Temp_Year.nc")
    annotation (Placement(transformation(extent={{-100,-20},{-40,40}})));
  annotation (experiment(
      StartTime=0,
      StopTime=3.1536e+07,
      Interval=1,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Euler"),
                   __Dymola_experimentSetupOutput(events=false),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This is an example for the model <a href=\"AixLib.Utilities.Sources.NcDataReader\">NcDataReader</a>. It simulates the air temperatur of the year 2010 and the region 12. The attribute &QUOT;float_ex&QUOT; is just a random value to show the use for attributes of type Real.</p>
</html>", revisions="<html>
<ul>
<li><i>Feburary 1, 2017</i> by Fabian Wuellhorst:<br>Implemented.</li>
</ul>
</html>"));
end NcDataReader;
