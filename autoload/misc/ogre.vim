function! misc#ogre#loadAbbreviation()
  "ogre related
  :iab <buffer> OGS getSingleton()
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
