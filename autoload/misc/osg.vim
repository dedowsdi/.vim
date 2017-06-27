function! misc#osg#loadAbbreviation()
  "macro
  :iab <buffer> ola OSG_ALWAYS << 
  :iab <buffer> olf OSG_FATAL << 
  :iab <buffer> olw OSG_WARN << 
  :iab <buffer> oln OSG_NOTICE << 
  :iab <buffer> oli OSG_INFO << 
  :iab <buffer> old OSG_DEBUG << 
  :iab <buffer> oldf OSG_DEBUG_FP << 

  "osg 
  :iab <buffer> o osg::
  :iab <buffer> od osgDB::
  :iab <buffer> ou osgUtil::
  :iab <buffer> or osg::ref_ptr<><Left>
  :iab <buffer> ov2 osg::Vec2
  :iab <buffer> ov3 osg::Vec3
  :iab <buffer> ov4 osg::Vec4
  :iab <buffer> ov2a osg::Vec2Array
  :iab <buffer> ov3a osg::Vec3Array
  :iab <buffer> ov4a osg::Vec4Array
  :iab <buffer> oa osg::Array
  :iab <buffer> on osg::Node
  :iab <buffer> og osg::Group
  :iab <buffer> ogm osg::Geometry
  :iab <buffer> ol osg::Geode
  :iab <buffer> omt osg::MatrixTransform
  :iab <buffer> oat osg::AutoTransform
  :iab <buffer> onl osg::NodeList
  :iab <buffer> ols osg::LightSource
  :iab <buffer> oi osg::Image
  :iab <buffer> ot osg::Texture
  :iab <buffer> ot1 osg::Texture1D
  :iab <buffer> ot2 osg::Texture2D
  :iab <buffer> opat osg::PositionAttitudeTransform
  :iab <buffer> om osg::Matrix
  :iab <buffer> oq osg::Quat
  :iab <buffer> oc osg::Camera
  :iab <buffer> op osg::Program
  :iab <buffer> osd osg::ShapeDrawable
  :iab <buffer> os osg::Shader
  :iab <buffer> ouf osg::Uniform
  :iab <buffer> oss osg::StateSet
  :iab <buffer> osa osg::StateAttribute
  :iab <buffer> ops osg::PointSprite
  :iab <buffer> opm osg::PolygonMode
  :iab <buffer> opo osg::PolygonOffset
  :iab <buffer> obf osg::BlendFunc
  :iab <buffer> otm osg::TexMat
  :iab <buffer> obe osg::BlendEquation
  :iab <buffer> obc osg::BlendColor
  :iab <buffer> ocf osg::CullFace
  :iab <buffer> ob osg::Billboard
  :iab <buffer> ocs osg::CullSettings
  :iab <buffer> ogc osg::GraphicsContext
  :iab <buffer> ods osg::DisplaySettings
  :iab <buffer> obb osg::BoundingBox
  :iab <buffer> obs osg::BoundingSphere
  :iab <buffer> oax osg::X_AXIS
  :iab <buffer> oay osg::Y_AXIS
  :iab <buffer> oaz osg::Z_AXIS
  :iab <buffer> op1 osg::PI
  :iab <buffer> op2 osg::PI_2
  :iab <buffer> op4 osg::PI_4
  :iab <buffer> opv osg::PrimitiveSet
  :iab <buffer> oda osg::DrawArrays
  :iab <buffer> ode osg::DrawElements
  :iab <buffer> odeui osg::DrawElementsUInt
  :iab <buffer> odeus osg::DrawElementsUShort

  "osgAnimation
  :iab <buffer> oap osg::AnimationPath
  :iab <buffer> oaiocm osgAnimation::InOutCubicMotion
  :iab <buffer> oaicm osgAnimation::InCubicMotion
  :iab <buffer> oaocm osgAnimation::OutCubicMotion
  :iab <buffer> oapc osg::AnimationPathCallback

  "osgParticle
  :iab <buffer> opr4 osgParticle::rangev4
  :iab <buffer> opr3 osgParticle::rangev3
  :iab <buffer> opr2 osgParticle::rangef
  :iab <buffer> opp osgParticle::Particle
  :iab <buffer> opli osgParticle::LinearInterpolator
  :iab <buffer> opps osgParticle::ParticleSystem
  :iab <buffer> oppp osgParticle::ParticleProcessor
  :iab <buffer> opme osgParticle::ModularEmitter
  :iab <buffer> opmp osgParticle::ModularProgram
  :iab <buffer> oppsu osgParticle::ParticleSystemUpdater
  :iab <buffer> oprrc osgParticle::RandomRateCounter
  :iab <buffer> opao osgParticle::AccelOperator
  :iab <buffer> oprs osgParticle::RadialShooter

	"osgGA
  :iab <buffer> ogcm osgGA::CameraManipulator
  :iab <buffer> ogsm osgGA::StandardManipulator
  :iab <buffer> ogom osgGA::OrbitManipulator
  :iab <buffer> ogtm osgGA::TrackballManipulator
  :iab <buffer> ogfpm osgGA::FirstPersonManipulator
  :iab <buffer> ogfm osgGA::FlightManipulator
  :iab <buffer> ogdm osgGA::DriveManipulator
  :iab <buffer> oggea osgGA::GUIEventAdapter
  :iab <buffer> oggaa osgGA::GUIActionAdapter

	"osgText
  :iab <buffer> otf osgText::Font
  :iab <buffer> ott osgText::Text
  :iab <buffer> otf3 osgText::Font3D
  :iab <buffer> ott3 osgText::Text3D
  :iab <buffer> ottb osgText::TextBase

	"osgViewer
  :iab <buffer> ovv osgViewer::Viewer
  :iab <buffer> ovsh osgViewer::StatsHandler

	"osgShadow
  :iab <buffer> ossm osgShadow::ShadowMap
  :iab <buffer> osss osgShadow::ShadowedScene

	"osgUtil
  :iab <buffer> oupv osgUtil::PrintVisitor
  :iab <buffer> out osgUtil::Tessellator
  :iab <buffer> oui osgUtil::Intersector
  :iab <buffer> ouls osgUtil::LineSegment
  :iab <buffer> oulsi osgUtil::LineSegmentIntersector
  :iab <buffer> ouiv osgUtil::IntersectionVisitor

  "osgFX
  :iab <buffer> ofo osgFX::Outline

endfunction
