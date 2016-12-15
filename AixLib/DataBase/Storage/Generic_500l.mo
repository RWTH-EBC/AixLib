within AixLib.DataBase.Storage;
record Generic_500l "Generic storage data for a 500 l storage"
  extends BufferStorageBaseDataDefinition(
    h_Tank=1.643 - h_lower_ports,
    h_HC1_up=h_Tank - h_lower_ports,
    h_HC1_low=h_HC1_up,
    h_HC2_up=0.7,
    h_HC2_low=h_HC2_up,
    h_HR=1,
    h_lower_ports=0.148/2,
    h_upper_ports=h_Tank - h_lower_ports,
    d_Tank=0.650,
    s_wall=0.005,
    s_ins=0.08,
    lambda_wall=50,
    lambda_ins=0.045,
    h_TS1=h_lower_ports,
    h_TS2=h_upper_ports,
    rho_ins=373,
    c_ins=1000,
    rho_wall=373,
    c_wall=1000,
    roughness=2.5e-5,
    Pipe_HC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    Pipe_HC2=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    Length_HC1=Modelica.Constants.eps,
    Length_HC2=Modelica.Constants.eps);


  annotation (Icon(graphics),               Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Buffer Storage: Buderus Logalux SF 500 l</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.BufferStorage.BufferStorageHeatingcoils\">HVAC.Components.BufferStorage.BufferStorageHeatingcoils</a></p>
</html>"));
end Generic_500l;
