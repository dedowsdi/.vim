function! abbre#glsl()
  "cpp abbrevation
  :iab <buffer>  sI #include
  :iab <buffer>  ssc static_cast<>()<Left><Left><Left>
  :iab <buffer>  sdc dynamic_cast<>()<left><left><left>
  :iab <buffer>  scc const_cast<>()<left><left><left>
  :iab <buffer>  src reinterpret_cast<>()<left><left><left>
  :iab <buffer>  sss std::stringstream
  :iab <buffer>  sspc std::static_pointer_cast<>()<left><left><left>
  :iab <buffer>  sdpc std::dynamic_pointer_cast<>()<left><left><left>
  :iab <buffer>  scpc std::const_pointer_cast<>()<left><left><left>
  :iab <buffer>  srpc std::reinterpret_pointer_cast<>()<left><left><left>
  :iab <buffer>  sup std::unique_ptr<><Left>
  :iab <buffer>  ssp std::shared_ptr<><Left>
  :iab <buffer>  sup std::unique_ptr<><Left>
  :iab <buffer>  swp std::weak_ptr<><Left>
  :iab <buffer>  sap std::auto_ptr<><Left>
  :iab <buffer>  sfl std::forward_list<><Left>
  :iab <buffer>  sus std::unordered_set<><Left>
  :iab <buffer>  sum std::unordered_map<><Left>
  :iab <buffer>  stpt template<typename T><Left>
  :iab <buffer>  stpc template<class T><Left>
  :iab <buffer>  cfoff // clang-format off
  :iab <buffer>  cfon // clang-format on

  :iab <buffer> smd #ifdef _DEBUG<CR>#endif<esc>O
  :iab <buffer> smif #if<CR>#endif<esc>O

  "boost  abbreviation
  :iab <buffer> br boost::regex
  :iab <buffer> brm boost::regex_match()<Left>
  :iab <buffer> brs boost::regex_search()<Left>
  :iab <buffer> brr boost::regex_replace()<Left>
  :iab <buffer> bsm boost::smatch

  :iab <buffer>  Cfs //------------------------------------------------------------------------------
endfunction

function! abbre#cpp()
  :iab <buffer>  sI #include
  :iab <buffer>  ssc static_cast<>()<Left><Left><Left>
  :iab <buffer>  sdc dynamic_cast<>()<left><left><left>
  :iab <buffer>  scc const_cast<>()<left><left><left>
  :iab <buffer>  src reinterpret_cast<>()<left><left><left>
  :iab <buffer>  sss std::stringstream
  :iab <buffer>  sspc std::static_pointer_cast<>()<left><left><left>
  :iab <buffer>  sdpc std::dynamic_pointer_cast<>()<left><left><left>
  :iab <buffer>  scpc std::const_pointer_cast<>()<left><left><left>
  :iab <buffer>  srpc std::reinterpret_pointer_cast<>()<left><left><left>
  :iab <buffer>  sup std::unique_ptr<><Left>
  :iab <buffer>  ssp std::shared_ptr<><Left>
  :iab <buffer>  sup std::unique_ptr<><Left>
  :iab <buffer>  swp std::weak_ptr<><Left>
  :iab <buffer>  sap std::auto_ptr<><Left>
  :iab <buffer>  sfl std::forward_list<><Left>
  :iab <buffer>  sus std::unordered_set<><Left>
  :iab <buffer>  sum std::unordered_map<><Left>
  :iab <buffer>  stpt template<typename T><Left>
  :iab <buffer>  stpc template<class T><Left>
  :iab <buffer>  cfoff // clang-format off
  :iab <buffer>  cfon // clang-format on

  :iab <buffer> smd #ifdef _DEBUG<CR>#endif<esc>O
  :iab <buffer> smif #if<CR>#endif<esc>O

  "boost  abbreviation
  :iab <buffer> br boost::regex
  :iab <buffer> brm boost::regex_match()<Left>
  :iab <buffer> brs boost::regex_search()<Left>
  :iab <buffer> brr boost::regex_replace()<Left>
  :iab <buffer> bsm boost::smatch

  :iab <buffer>  Cfs //------------------------------------------------------------------------------
endfunction

function! abbre#opengl()
  :iab <buffer> glc  GLchar
  :iab <buffer> glb  GLbyte
  :iab <buffer> glub GLubyte
  :iab <buffer> gls  GLshort
  :iab <buffer> glus GLushort
  :iab <buffer> gli  GLint
  :iab <buffer> glui GLuint
  :iab <buffer> glf  GLfloat
  :iab <buffer> gld  GLdouble
  :iab <buffer> glv  GLvoid
  :iab <buffer> gle  GLenum
  :iab <buffer> glz  GLsizei
  :iab <buffer> glb  GLboolean
  :iab <buffer> glbf GLbitfield
  :iab <buffer> glv GLvoid
  :iab <buffer> glsi GLsizei
  :iab <buffer> glcf GLclampf
  :iab <buffer> glcd GLclampf
  :iab <buffer> gl_  GL_
endfunction

function! abbre#mygui()
  :iab <buffer> M MyGUI

  "mygui widget
  :iab <buffer> Mwb MyGUI::Button
  :iab <buffer> Mwc MyGUI::Canvas
  :iab <buffer> Mwcb MyGUI::ComboBox
  :iab <buffer> Mwddc MyGUI::DDContainer
  :iab <buffer> Mweb MyGUI::EditBox
  :iab <buffer> Mwib MyGUI::ItemBox
  :iab <buffer> Mwibox MyGUI::ImageBox
  :iab <buffer> Mwlb MyGUI::ListBox
  :iab <buffer> Mwmb MyGUI::MenuBar
  :iab <buffer> Mwmc MyGUI::MenuControl
  :iab <buffer> Mwmi MyGUI::MenuItem
  :iab <buffer> Mwmlb MyGUI::MultiListBox
  :iab <buffer> Mwmli MyGUI::MultiListItem
  :iab <buffer> Mwpb MyGUI::ProgressBar
  :iab <buffer> Mwpm MyGUI::PopupMenu
  :iab <buffer> Mwsb MyGUI::ScrollBar
  :iab <buffer> Mwsv MyGUI::ScrollView
  :iab <buffer> Mwtb MyGUI::TextBox
  :iab <buffer> Mwtc MyGUI::TabControl
  :iab <buffer> Mwti MyGUI::TabItem
  :iab <buffer> Mww MyGUI::Widget
  :iab <buffer> Mwwin MyGUI::Window

  "mygui manager
  :iab <buffer> Mmgc MyGUI::ControllerManager
  :iab <buffer> Mmgcb MyGUI::ClipboardManager
  :iab <buffer> Mmgdl MyGUI::DynLibManager
  :iab <buffer> Mmgf MyGUI::FontManager
  :iab <buffer> Mmgfac MyGUI::FactoryManager
  :iab <buffer> Mmgi MyGUI::InputManager
  :iab <buffer> Mmgl MyGUI::LogManager
  :iab <buffer> Mmglan MyGUI::LanguageManager
  :iab <buffer> Mmglaye MyGUI::LayerManager
  :iab <buffer> Mmglayo MyGUI::LayoutManager
  :iab <buffer> Mmgplu MyGUI::PluginManager
  :iab <buffer> Mmgpoi MyGUI::PointerManager
  :iab <buffer> Mmgren MyGUI::RenderManager
  :iab <buffer> Mmgres MyGUI::ResourceManager
  :iab <buffer> Mmgs MyGUI::SkinManager
  :iab <buffer> Mmgsw MyGUI::SubWidgetManager
  :iab <buffer> Mmgtt MyGUI::ToolTipManager
  :iab <buffer> Mmgw MyGUI::WidgetManager

  "mygui singleton
  :iab <buffer> Msgcm MyGUI::ControllerManager::getSingleton()
  :iab <buffer> Msgcbm MyGUI::ClipboardManager::getSingleton()
  :iab <buffer> Msgdlm MyGUI::DynLibManager::getSingleton()
  :iab <buffer> Msgfm MyGUI::FontManager::getSingleton()
  :iab <buffer> Msgfacm MyGUI::FactoryManager::getSingleton()
  :iab <buffer> Msgim MyGUI::InputManager::getSingleton()
  :iab <buffer> Msglm MyGUI::LogManager::getSingleton()
  :iab <buffer> Msglanm MyGUI::LanguageManager::getSingleton()
  :iab <buffer> Msglayem MyGUI::LayerManager::getSingleton()
  :iab <buffer> Msglayom MyGUI::LayoutManager::getSingleton()
  :iab <buffer> Msgplum MyGUI::PluginManager::getSingleton()
  :iab <buffer> Msgpoim MyGUI::PointerManager::getSingleton()
  :iab <buffer> Msgrenm MyGUI::RenderManager::getSingleton()
  :iab <buffer> Msgresm MyGUI::ResourceManager::getSingleton()
  :iab <buffer> Msgsm MyGUI::SkinManager::getSingleton()
  :iab <buffer> Msgswm MyGUI::SubWidgetManager::getSingleton()
  :iab <buffer> Msgttm MyGUI::ToolTipManager::getSingleton()
  :iab <buffer> Msgwm MyGUI::WidgetManager::getSingleton()
endfunction

function! abbre#osg()
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
  :iab <buffer> ospc osg::static_pointer_cast<>()<Left><Left><Left>
  :iab <buffer> odpc osg::dynamic_pointer_cast<>()<Left><Left><Left>
  :iab <buffer> ocpc osg::const_pointer_cast<>()<Left><Left><Left>
  :iab <buffer> od osgDB::
  :iab <buffer> ou osgUtil::
  :iab <buffer> or osg::ref_ptr<><Left>
  :iab <buffer> ovp osg::Viewport
  :iab <buffer> ov2 osg::Vec2
  :iab <buffer> ov3 osg::Vec3
  :iab <buffer> ov4 osg::Vec4
  :iab <buffer> ov2a osg::Vec2Array
  :iab <buffer> ov3a osg::Vec3Array
  :iab <buffer> ov4a osg::Vec4Array
  :iab <buffer> oba osg::ByteArray
  :iab <buffer> osa osg::ShortArray
  :iab <buffer> oia osg::IntArray
  :iab <buffer> ofa osg::FloatArray
  :iab <buffer> oda osg::DoubleArray
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
  :iab <buffer> ocbv osg::ComputeBoundsVisitor
  :iab <buffer> ofs osg::FrameStamp
  :iab <buffer> osgds osg::DisplaySettings::instance()
  :iab <buffer> osgau osg::Applicationusage::instance()
  :iab <buffer> osgt osg::Timer::instance()

  "osgAnimation
  :iab <buffer> oap osg::AnimationPath
  :iab <buffer> oapc osg::AnimationPathCallback
  :iab <buffer> oaiocm osgAnimation::InOutCubicMotion
  :iab <buffer> oaicm osgAnimation::InCubicMotion
  :iab <buffer> oaocm osgAnimation::OutCubicMotion
  :iab <buffer> oabam osgAnimation::BasicAnimationManager
  :iab <buffer> oadsc osgAnimation::DoubleStepChannel
  :iab <buffer> oafsc osgAnimation::FloatStepChannel
  :iab <buffer> oav2sc osgAnimation::Vec2StepChannel
  :iab <buffer> oav3sc osgAnimation::Vec3StepChannel
  :iab <buffer> oav4sc osgAnimation::Vec4StepChannel
  :iab <buffer> oaqsc osgAnimation::QuatStepChannel
  :iab <buffer> oadlc osgAnimation::DoubleLinearChannel
  :iab <buffer> oaflc osgAnimation::FloatLinearChannel
  :iab <buffer> oav2lc osgAnimation::Vec2LinearChannel
  :iab <buffer> oav3lc osgAnimation::Vec3LinearChannel
  :iab <buffer> oav4lc osgAnimation::Vec4LinearChannel
  :iab <buffer> oaqslc osgAnimation::QuatSphericalLinearChannel
  :iab <buffer> oamlc osgAnimation::MatrixLinearChannel
  :iab <buffer> oafcbc osgAnimation::FloatCubicBezierChannel
  :iab <buffer> oadcbc osgAnimation::DoubleCubicBezierChannel
  :iab <buffer> oav2cbc osgAnimation::Vec2CubicBezierChannel
  :iab <buffer> oav3cbc osgAnimation::Vec3CubicBezierChannel
  :iab <buffer> oav4cbc osgAnimation::Vec4CubicBezierChannel
  :iab <buffer> oadss osgAnimation::DoubleStepSampler
  :iab <buffer> oafss osgAnimation::FloatStepSampler
  :iab <buffer> oav2ss osgAnimation::Vec2StepSampler
  :iab <buffer> oav3ss osgAnimation::Vec3StepSampler
  :iab <buffer> oav4ss osgAnimation::Vec4StepSampler
  :iab <buffer> oaqss osgAnimation::QuatStepSampler
  :iab <buffer> oadls osgAnimation::DoubleLinearSampler
  :iab <buffer> oafls osgAnimation::FloatLinearSampler
  :iab <buffer> oav2ls osgAnimation::Vec2LinearSampler
  :iab <buffer> oav3ls osgAnimation::Vec3LinearSampler
  :iab <buffer> oav4ls osgAnimation::Vec4LinearSampler
  :iab <buffer> oaqsls osgAnimation::QuatSphericalLinearSampler
  :iab <buffer> oamls osgAnimation::MatrixLinearSampler
  :iab <buffer> oafcbs osgAnimation::FloatCubicBezierSampler
  :iab <buffer> oadcbs osgAnimation::DoubleCubicBezierSampler
  :iab <buffer> oav2cbs osgAnimation::Vec2CubicBezierSampler
  :iab <buffer> oav3cbs osgAnimation::Vec3CubicBezierSampler
  :iab <buffer> oav4cbs osgAnimation::Vec4CubicBezierSampler
  :iab <buffer> oafkf osgAnimation::FloatKeyframe
  :iab <buffer> oafkfc osgAnimation::FloatKeyframeContainer
  :iab <buffer> oadkf osgAnimation::DoubleKeyframe
  :iab <buffer> oadkfc osgAnimation::DoubleKeyframeContainer
  :iab <buffer> oav2kf osgAnimation::Vec2Keyframe
  :iab <buffer> oav2kfc osgAnimation::Vec2KeyframeContainer
  :iab <buffer> oav3kf osgAnimation::Vec3Keyframe
  :iab <buffer> oav3kfc osgAnimation::Vec3KeyframeContainer
  :iab <buffer> oav4kf osgAnimation::Vec4Keyframe
  :iab <buffer> oav4kfc osgAnimation::Vec4KeyframeContainer
  :iab <buffer> oaqkf osgAnimation::QuatKeyframe
  :iab <buffer> oaqkfc osgAnimation::QuatKeyframeContainer
  :iab <buffer> oamkf osgAnimation::MatrixKeyframe
  :iab <buffer> oamkfc osgAnimation::MatrixKeyframeContainer
  :iab <buffer> oav3pkf osgAnimation::Vec3PackedKeyframe
  :iab <buffer> oav3pkfc osgAnimation::Vec3PackedKeyframeContainer
  :iab <buffer> oafcbkf osgAnimation::FloatCubicBezierKeyframe
  :iab <buffer> oafcbkfc osgAnimation::FloatCubicBezierKeyframeContainer
  :iab <buffer> oaumt osgAnimation::UpdateMatrixTransform
  :iab <buffer> oaum osgAnimation::UpdateMaterial
  :iab <buffer> oauu osgAnimation::UpdateUniform
  :iab <buffer> oaub osgAnimation::UpdateBone
  :iab <buffer> oasrae osgAnimation::StackedRotateAxisElement
  :iab <buffer> oassae osgAnimation::StackedScaleAxisElement
  :iab <buffer> oastae osgAnimation::StackedTranslateAxisElement
  :iab <buffer> oasme osgAnimation::StackedMatrixAxisElement
  :iab <buffer> oasqe osgAnimation::StackedQuaternionAxisElement

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
  :iab <buffer> ovcv osgViewer::CompositeViewer
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
  
  "osgDB
  :iab <buffer> odsgr osgDB::Registry::instance()
  :iab <buffer> odssm osgDB::SharedStateManager

  "osgWidget
  :iab <buffer> owwm osgWidget::WindowManager
  :iab <buffer> owsm osgWidget::StyleManager
  :iab <buffer> owbm osgWidget::BrowserManager
  :iab <buffer> owt osgWidget::Table
  :iab <buffer> owl osgWidget::Label
  :iab <buffer> owi osgWidget::Input
  :iab <buffer> owc osgWidget::Canvas
  :iab <buffer> owb osgWidget::Box
  :iab <buffer> owe osgWidget::Event
  :iab <buffer> oww osgWidget::Widget


endfunction

function! abbre#ogre()
  "ogre related
  :iab <buffer> O Ogre

  "ogre geometry
  :iab <buffer> Ogp Ogre::Plane
  :iab <buffer> Ogr Ogre::Ray

  "ogre hlms
  :iab <buffer> Ohbb Ogre::HlmsBlendblock
  :iab <buffer> Ohdb Ogre::HlmsDatablock
  :iab <buffer> Ohl Ogre::HlmsListener
  :iab <buffer> Ohm Ogre::HlmsManager
  :iab <buffer> Ohmb Ogre::HlmsMacroblock
  :iab <buffer> Ohjp Ogre::HlmsJsonPbs
  :iab <buffer> Ohpdb Ogre::HlmsPbsDatablock
  :iab <buffer> Ohp Ogre::HlmsPbs
  :iab <buffer> Ohju Ogre::HlmsJsonUnlit
  :iab <buffer> Ohudb Ogre::HlmsUnlitDatablock
  :iab <buffer> Ohu Ogre::HlmsUnlit
  :iab <buffer> Ohup Ogre::UnlitProperty

  "ogre compositor
  :iab <buffer> Occ Ogre::CompositorChannel
  :iab <buffer> Occom Ogre::CompositorCommon
  :iab <buffer> Occpp Ogre::CompositorPassProvider
  :iab <buffer> Ocm2 Ogre::CompositorManager2
  :iab <buffer> Ocn Ogre::CompositorNode
  :iab <buffer> Ocnv Ogre::CompositorNodeVec
  :iab <buffer> Ocnd Ogre::CompositorNodeDef
  :iab <buffer> Ocp Ogre::CompositorPass
  :iab <buffer> Ocpc Ogre::PassClear
  :iab <buffer> Ocpd Ogre::CompositorPassDef
  :iab <buffer> Ocpdc Ogre::PassDepthCopy
  :iab <buffer> Ocpm Ogre::PassMipmap
  :iab <buffer> Ocpq Ogre::PassQuad
  :iab <buffer> Ocps Ogre::PassScene
  :iab <buffer> Ocpsten Ogre::PassStencil
  :iab <buffer> Ocpu Ogre::PassUav
  :iab <buffer> Ocsn Ogre::CompositorShadowNode
  :iab <buffer> Ocsnd Ogre::CompositorShadowNodeDef
  :iab <buffer> Octd Ogre::TextureDefinition
  :iab <buffer> Ocw Ogre::CompositorWorkspace
  :iab <buffer> Ocwd Ogre::CompositorWorkspaceDef
  :iab <buffer> Ocwl Ogre::CompositorWorkspaceListener

  "ogre math
  :iab <buffer> Om Ogre::Math
  :iab <buffer> Omd Ogre::Degree
  :iab <buffer> Omm3 Ogre::Matrix3
  :iab <buffer> Omm4 Ogre::Matrix4
  :iab <buffer> Omq Ogre::Quaternion
  :iab <buffer> Omr Ogre::Real
  :iab <buffer> Omrad Ogre::Radian
  :iab <buffer> Omv2 Ogre::Vector2
  :iab <buffer> Omv3 Ogre::Vector3
  :iab <buffer> Omv4 Ogre::Vector4

  "ogre node
  :iab <buffer> Onb Ogre::Bone
  :iab <buffer> Onn Ogre::Node
  :iab <buffer> Onsn Ogre::SceneNode
  :iab <buffer> Ontp Ogre::TagPoint
  :iab <buffer> Onnvi Ogre::Node::NodeVecIterator

  "ogre movable
  :iab <buffer> Ooc Ogre::Camera
  :iab <buffer> Ooi Ogre::Item
  :iab <buffer> Ool Ogre::Light
  :iab <buffer> Ooman Ogre::ManualObject
  :iab <buffer> Oomo Ogre::MovableObject
  :iab <buffer> Oop Ogre::Particle;
  :iab <buffer> Oopa Ogre::ParticleAffector
  :iab <buffer> Oope Ogre::ParticleEmitter
  :iab <buffer> Oops Ogre::ParticleSystem
  :iab <buffer> Oopsm Ogre::ParticleSystemManager
  :iab <buffer> Oopsr Ogre::ParticleSystemRenderer

  "ogre render
  :iab <buffer> Ort Ogre::RenderTarget
  :iab <buffer> Ortex Ogre::RenderTexture
  :iab <buffer> Orq Ogre::RenderQueue
  :iab <buffer> Ors Ogre::RenderSystem
  :iab <buffer> Orw Ogre::RenderWindow

  "ogre string related
  :iab <buffer> Os Ogre::String
  :iab <buffer> Osc Ogre::StringConverter
  :iab <buffer> Osu Ogre::StringUtil
  :iab <buffer> Ot Ogre::Texture

  "ogre singleton
  :iab <buffer> Osgam Ogre::ArchiveManager::getSingleton()
  :iab <buffer> Osgcm Ogre::ControllerManager::getSingleton()
  :iab <buffer> Osgdl DynLibManager::getSingleton()
  :iab <buffer> Osgets ExternalTextureSourceManager::getSingleton()
  :iab <buffer> Osggp GpuProgramManager::getSingleton()
  :iab <buffer> Osghlgp HighLevelGpuProgramManager::getSingleton()
  :iab <buffer> Osglm Ogre::LogManager::getSingleton()
  :iab <buffer> Osgls LodStrategyManager::getSingleton()
  :iab <buffer> Osgmm MeshManager::getSingleton()
  :iab <buffer> Osgmma MaterialManager::getSingleton()
  :iab <buffer> Osgpsm Ogre::ParticleSystemManager::getSingleton()
  :iab <buffer> Osgr Ogre::Root::getSingleton()
  :iab <buffer> Osgrg ResourceGroupManager::getSingleton()
  :iab <buffer> Osgrm ResourceManager::getSingleton()
  :iab <buffer> Osgrsc RenderSystemCapabilitiesManager::getSingleton()
  :iab <buffer> Osgs SkeletonManager::getSingleton()
  :iab <buffer> Osgst ShadowTextureManager::getSingleton()
  :iab <buffer> Osgt TextureManager::getSingleton()

  "ogre manager
  :iab <buffer> Omga Ogre::ArchiveManager
  :iab <buffer> Omgam Ogre::ArrayMemoryManager
  :iab <buffer> Omgbm Ogre::BoneMemoryManager
  :iab <buffer> Omgc Ogre::ControllerManager
  :iab <buffer> Omgc2 Ogre::CompositorManager2
  :iab <buffer> Omgdl Ogre::DynLibManager
  :iab <buffer> Omgets Ogre::ExternalTextureSourceManager
  :iab <buffer> Omggp Ogre::GpuProgramManager
  :iab <buffer> Omgh Ogre::HlmsManager
  :iab <buffer> Omghlgp Ogre::HighLevelGpuProgramManager
  :iab <buffer> Omght Ogre::HlmsTextureManager
  :iab <buffer> Omgi Ogre::InstanceManager
  :iab <buffer> Omgl Ogre::LogManager
  :iab <buffer> Omgls Ogre::LodStrategyManager
  :iab <buffer> Omgm Ogre::MeshManager
  :iab <buffer> Omgmat Ogre::MaterialManager
  :iab <buffer> Omgmem Ogre::MemoryManager
  :iab <buffer> Omgnm Ogre::NodeMemoryManager
  :iab <buffer> Omgom Ogre::ObjectMemoryManager
  :iab <buffer> Omgos Ogre::OldSkeletonManager
  :iab <buffer> Omgps Ogre::ParticleSystemManager
  :iab <buffer> Omgr Ogre::ResourceManager
  :iab <buffer> Omgrg Ogre::ResourceGroupManager
  :iab <buffer> Omgrsc Ogre::RenderSystemCapabilitiesManager
  :iab <buffer> Omgs Ogre::SceneManager
  :iab <buffer> Omgsc Ogre::ScriptCompilerManager
  :iab <buffer> Omgske Ogre::SkeletonManager
  :iab <buffer> Omgst Ogre::ShadowTextureManager
  :iab <buffer> Omgt Ogre::TextureManager
  :iab <buffer> Omgv Ogre::VaoManager

  :iab <buffer> Oecbt Ogre::ColourBufferType
  :iab <buffer> Oecf Ogre::CompareFunction
  :iab <buffer> Oecm Ogre::CullingMode
  :iab <buffer> Oecr Ogre::ClipResult
  :iab <buffer> Oefbt Ogre::FrameBufferType
  :iab <buffer> Oefm Ogre::FogMode
  :iab <buffer> Oefo Ogre::FilterOptions
  :iab <buffer> Oeft Ogre::FilterType
  :iab <buffer> Oeimf Ogre::InstanceManagerFlags
  :iab <buffer> Oepm Ogre::PolygonMode
  :iab <buffer> Oesm Ogre::SortMode
  :iab <buffer> Oesmmt Ogre::SceneMemoryMgrTypes
  :iab <buffer> Oesmt Ogre::StereoModeType
  :iab <buffer> Oeso Ogre::ShadeOptions
  :iab <buffer> Oeso Ogre::StencilOperation
  :iab <buffer> Oest Ogre::ShaderType
  :iab <buffer> Oetfo Ogre::TextureFilterOptions
  :iab <buffer> Oetvc Ogre::TrackVertexColourEnum
  :iab <buffer> Oevp Ogre::VertexPass
  :iab <buffer> Oewt Ogre::WaveformType
  :iab <buffer> Oellt Ogre::Light::LightTypes
  :iab <buffer> Oents Ogre::Node::TransformSpace
endfunction

function! abbre#qt()
endfunction
