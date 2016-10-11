within AixLib.DataBase.Storage;
record Generic_New_2000l "Pseudo storage with 2000 l (standing)"
  extends BufferStorageBaseDataDefinition(
    h_Tank=2.145,
    h_lower_ports=0.1,
    h_upper_ports=2.1,
    h_HC1_up=1.60,
    h_HC1_low=0.1,
    h_HC2_up=0.7,
    h_HC2_low=0.1,
    h_HR=1,
    d_Tank=1.090,
    s_wall=0.005,
    s_ins=0.12,
    lambda_wall=50,
    lambda_ins=0.045,
    h_TS1=0.1,
    h_TS2=2.1,
    rho_ins=373,
    c_ins=1000,
    rho_wall=373,
    c_wall=1000,
    roughness=2.5e-5,
    Pipe_HC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    Pipe_HC2=DataBase.Pipes.Copper.Copper_28x1(),
    Length_HC1=118,
    Length_HC2=22);

  annotation (Icon(graphics),               Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Buffer Storage: Generic 2000 l</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.BufferStorage.BufferStorageHeatingcoils\">HVAC.Components.BufferStorage.BufferStorageHeatingcoils</a></p>
</html>"));
end Generic_New_2000l;
