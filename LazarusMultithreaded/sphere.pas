UNIT Sphere;

INTERFACE

USES
  Utils, Vector, Ray;

CONST
  SurfaceType_Diffuse    = 0;
  SurfaceType_Specular   = 1;
  SurfaceType_Refractive = 2;

TYPE
  TSphere = CLASS
  PUBLIC
    Radius      : FloatType;
    Position    : TVector;
    Emission    : TVector;
    Colour      : TVector;
    SurfaceType : INTEGER;
  PUBLIC
    CONSTRUCTOR Create(Radius : FloatType; Position, Emission, Colour : TVector; SurfaceType : INTEGER);
    FUNCTION Intersect(VAR Ray : TRay) : FloatType;
  END;

IMPLEMENTATION

CONSTRUCTOR TSphere.Create(Radius : FloatType; Position, Emission, Colour : TVector; SurfaceType : INTEGER);
BEGIN
  self.Radius      := Radius;
  self.Position    := Position;
  self.Emission    := Emission;
  self.Colour      := Colour;
  self.SurfaceType := SurfaceType;
END;

FUNCTION TSphere.Intersect(VAR Ray : TRay) : FloatType;
VAR
  op  : TVector;
  eps : FloatType;
  b   : FloatType;
  det : FloatType;
  t   : FloatType;
BEGIN
  Result := 0;

  Vector_Sub(op, self.Position, Ray.Origin);
  eps := 1e-4;
  b   := Vector_Dot(op, Ray.Direction);
  det := (b * b) - Vector_Dot(op, op) + (self.Radius * self.Radius);
  IF (det < 0.0) THEN
    exit
  ELSE
    det := sqrt(det);

  IF (b - det > eps) THEN
    Result := b - det
  ELSE
  IF (b + det > eps) THEN
    Result := b + det;
END;

END.

