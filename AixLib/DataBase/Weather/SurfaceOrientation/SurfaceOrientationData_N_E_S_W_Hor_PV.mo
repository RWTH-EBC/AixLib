within AixLib.DataBase.Weather.SurfaceOrientation;
record SurfaceOrientationData_N_E_S_W_Hor_PV
 "North, East, South, West, Horizontal, South 30° Tilt"
  extends SurfaceOrientationBaseDataDefinition(nSurfaces = 5, name = {"N", "O", "S", "W", "Hor", "PV"}, Azimut = {180, -90, 0, 90, 0, 0}, Tilt = {90, 90, 90, 90, 0, 30});
                                                                                                                                                                           annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SurfaceOrientationData_N_E_S_W_Hor_PV;
