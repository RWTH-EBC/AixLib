within AixLib.DataBase.Chiller.EN14511;
record Vitocal200AWO201 "Vitocal200AWO201Chilling"
  extends AixLib.DataBase.Chiller.ChillerBaseDataDefinition(
    tableP_ele=[0, 20, 25, 27, 30, 35; 7,1380.0, 1590.0, 1680.0, 1800.0, 1970.0;  18,950.0, 1060.0, 1130.0, 1200.0, 1350.0],
    tableQdot_eva=[0, 20, 25, 27, 30, 35; 7,2540.0, 2440.0, 2370.0, 2230.0, 2170.0;  18, 5270.0, 5060.0, 4920.0, 4610.0, 4500.0],
    mFlow_conNom=3960/4180/5,
    mFlow_evaNom=(2250*1.2)/3600,
    tableUppBou=[20, 20; 35, 20]);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Data&#160;record&#160;for&#160;type&#160;AWO-M/AWO-M-E-AC&#160;201.A04,
  obtained from the technical guide in the UK. <a href=
  \"https://professionals.viessmann.co.uk/content/dam/vi-brands/UK/PDFs/Datasheets/Vitocal%20Technical%20Guide.PDF/_jcr_content/renditions/original.media_file.download_attachment.file/Vitocal%20Technical%20Guide.PDF\">
  Link</a> to the datasheet
</p>
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end Vitocal200AWO201;
