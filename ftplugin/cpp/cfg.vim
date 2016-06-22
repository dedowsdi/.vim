if exists("g:loaded_cppcfg")
  finish
endif
let g:loaded_cppcfg = 1

"cpp abbrevation
:iab sc static_cast<>()<Left><Left><Left>
:iab cs const std::string
:iab C const
:iab Sup std::unique_ptr<><Left>
:iab I include

"boost  abbreviation
:iab br boost::regex
:iab brm boost::regex_match()<Left>
:iab brs boost::regex_search()<Left>
:iab brr boost::regex_replace()<Left>
:iab bsm boost::smatch

"opengl abbreviation
:iab glb  GLbtype
:iab gls  GLshort
:iab gli  GLint
:iab glf  GLfloat
:iab gld  GLdobule
:iab glub GLubyte
:iab glus GLushort
:iab glui GLuint
:iab glc  GLchar
:iab glv  GLvoid
:iab gle  GLenum
:iab gl_  GL_
:iab glz  GLsizei

"ogre related
:iab OGS getSingleton()
:iab O Ogre

"ogre geometry
:iab Ogp Ogre::Plane
:iab Ogr Ogre::Ray

"ogre hlms
:iab Ohbb Ogre::HlmsBlendblock
:iab Ohdb Ogre::HlmsDatablock
:iab Ohl Ogre::HlmsListener
:iab Ohm Ogre::HlmsManager
:iab Ohmb Ogre::HlmsMacroblock
:iab Ohjp Ogre::HlmsJsonPbs
:iab Ohpdb Ogre::HlmsPbsDatablock
:iab Ohp Ogre::HlmsPbs
:iab Ohju Ogre::HlmsJsonUnlit
:iab Ohudb Ogre::HlmsUnlitDatablock
:iab Ohu Ogre::HlmsUnlit
:iab Ohup Ogre::UnlitProperty

"ogre compositor
:iab Occ Ogre::CompositorChannel
:iab Occom Ogre::CompositorCommon
:iab Occpp Ogre::CompositorPassProvider
:iab Ocm2 Ogre::CompositorManager2
:iab Ocn Ogre::CompositorNode
:iab Ocnv Ogre::CompositorNodeVec
:iab Ocnd Ogre::CompositorNodeDef
:iab Ocp Ogre::CompositorPass
:iab Ocpc Ogre::PassClear
:iab Ocpd Ogre::CompositorPassDef
:iab Ocpdc Ogre::PassDepthCopy
:iab Ocpm Ogre::PassMipmap
:iab Ocpq Ogre::PassQuad
:iab Ocps Ogre::PassScene
:iab Ocpsten Ogre::PassStencil
:iab Ocpu Ogre::PassUav
:iab Ocsn Ogre::CompositorShadowNode
:iab Ocsnd Ogre::CompositorShadowNodeDef
:iab Octd Ogre::TextureDefinition
:iab Ocw Ogre::CompositorWorkspace
:iab Ocwd Ogre::CompositorWorkspaceDef
:iab Ocwl Ogre::CompositorWorkspaceListener

"ogre math
:iab Om Ogre::Math
:iab Omd Ogre::Degree
:iab Omm3 Ogre::Matrix3
:iab Omm4 Ogre::Matrix4
:iab Omq Ogre::Quaternion
:iab Omr Ogre::Real
:iab Omrad Ogre::Radian
:iab Omv2 Ogre::Vector2
:iab Omv3 Ogre::Vector3
:iab Omv4 Ogre::Vector4

"ogre node
:iab Onb Ogre::Bone
:iab Onn Ogre::Node
:iab Onsn Ogre::SceneNode
:iab Ontp Ogre::TagPoint
:iab Onnvi Ogre::Node::NodeVecIterator

"ogre movable
:iab Ooc Ogre::Camera
:iab Ooi Ogre::Item
:iab Ool Ogre::Light
:iab Ooman Ogre::ManualObject
:iab Oomo Ogre::MovableObject
:iab Oop Ogre::Particle;
:iab Oopa Ogre::ParticleAffector
:iab Oope Ogre::ParticleEmitter
:iab Oops Ogre::ParticleSystem
:iab Oopsm Ogre::ParticleSystemManager
:iab Oopsr Ogre::ParticleSystemRenderer

"ogre render
:iab Ort Ogre::RenderTarget
:iab Ortex Ogre::RenderTexture
:iab Orq Ogre::RenderQueue
:iab Ors Ogre::RenderSystem
:iab Orw Ogre::RenderWindow

"ogre string related
:iab Os Ogre::String
:iab Osc Ogre::StringConverter
:iab Osu Ogre::StringUtil
:iab Ot Ogre::Texture

"ogre singleton
:iab Osgam Ogre::ArchiveManager::getSingleton()
:iab Osgcm Ogre::ControllerManager::getSingleton()
:iab Osgdl DynLibManager::getSingleton()
:iab Osgets ExternalTextureSourceManager::getSingleton()
:iab Osggp GpuProgramManager::getSingleton()
:iab Osghlgp HighLevelGpuProgramManager::getSingleton()
:iab Osglm Ogre::LogManager::getSingleton()
:iab Osgls LodStrategyManager::getSingleton()
:iab Osgmm MeshManager::getSingleton()
:iab Osgmma MaterialManager::getSingleton()
:iab Osgpsm Ogre::ParticleSystemManager::getSingleton()
:iab Osgr Ogre::Root::getSingleton()
:iab Osgrg ResourceGroupManager::getSingleton()
:iab Osgrm ResourceManager::getSingleton()
:iab Osgrsc RenderSystemCapabilitiesManager::getSingleton()
:iab Osgs SkeletonManager::getSingleton()
:iab Osgst ShadowTextureManager::getSingleton()
:iab Osgt TextureManager::getSingleton()

"ogre manager
:iab Omga Ogre::ArchiveManager
:iab Omgam Ogre::ArrayMemoryManager
:iab Omgbm Ogre::BoneMemoryManager
:iab Omgc Ogre::ControllerManager
:iab Omgc2 Ogre::CompositorManager2
:iab Omgdl Ogre::DynLibManager
:iab Omgets Ogre::ExternalTextureSourceManager
:iab Omggp Ogre::GpuProgramManager
:iab Omgh Ogre::HlmsManager
:iab Omghlgp Ogre::HighLevelGpuProgramManager
:iab Omght Ogre::HlmsTextureManager
:iab Omgi Ogre::InstanceManager
:iab Omgl Ogre::LogManager
:iab Omgls Ogre::LodStrategyManager
:iab Omgm Ogre::MeshManager
:iab Omgmat Ogre::MaterialManager
:iab Omgmem Ogre::MemoryManager
:iab Omgnm Ogre::NodeMemoryManager
:iab Omgom Ogre::ObjectMemoryManager
:iab Omgos Ogre::OldSkeletonManager
:iab Omgps Ogre::ParticleSystemManager
:iab Omgr Ogre::ResourceManager
:iab Omgrg Ogre::ResourceGroupManager
:iab Omgrsc Ogre::RenderSystemCapabilitiesManager
:iab Omgs Ogre::SceneManager
:iab Omgsc Ogre::ScriptCompilerManager
:iab Omgske Ogre::SkeletonManager
:iab Omgst Ogre::ShadowTextureManager
:iab Omgt Ogre::TextureManager
:iab Omgv Ogre::VaoManager

:iab Oecbt Ogre::ColourBufferType
:iab Oecf Ogre::CompareFunction
:iab Oecm Ogre::CullingMode
:iab Oecr Ogre::ClipResult
:iab Oefbt Ogre::FrameBufferType
:iab Oefm Ogre::FogMode
:iab Oefo Ogre::FilterOptions
:iab Oeft Ogre::FilterType
:iab Oeimf Ogre::InstanceManagerFlags
:iab Oepm Ogre::PolygonMode
:iab Oesm Ogre::SortMode
:iab Oesmmt Ogre::SceneMemoryMgrTypes
:iab Oesmt Ogre::StereoModeType
:iab Oeso Ogre::ShadeOptions
:iab Oeso Ogre::StencilOperation
:iab Oest Ogre::ShaderType
:iab Oetfo Ogre::TextureFilterOptions
:iab Oetvc Ogre::TrackVertexColourEnum
:iab Oevp Ogre::VertexPass
:iab Oewt Ogre::WaveformType
:iab Oellt Ogre::Light::LightTypes
:iab Oents Ogre::Node::TransformSpace

"mygui
:iab M MyGUI

"mygui widget
:iab Mwb MyGUI::Button
:iab Mwc MyGUI::Canvas
:iab Mwcb MyGUI::ComboBox
:iab Mwddc MyGUI::DDContainer
:iab Mweb MyGUI::EditBox
:iab Mwib MyGUI::ItemBox
:iab Mwibox MyGUI::ImageBox
:iab Mwlb MyGUI::ListBox
:iab Mwmb MyGUI::MenuBar
:iab Mwmc MyGUI::MenuControl
:iab Mwmi MyGUI::MenuItem
:iab Mwmlb MyGUI::MultiListBox
:iab Mwmli MyGUI::MultiListItem
:iab Mwpb MyGUI::ProgressBar
:iab Mwpm MyGUI::PopupMenu
:iab Mwsb MyGUI::ScrollBar
:iab Mwsv MyGUI::ScrollView
:iab Mwtb MyGUI::TextBox
:iab Mwtc MyGUI::TabControl
:iab Mwti MyGUI::TabItem
:iab Mww MyGUI::Widget
:iab Mwwin MyGUI::Window

"mygui manager
:iab Mmgc MyGUI::ControllerManager
:iab Mmgcb MyGUI::ClipboardManager
:iab Mmgdl MyGUI::DynLibManager
:iab Mmgf MyGUI::FontManager
:iab Mmgfac MyGUI::FactoryManager
:iab Mmgi MyGUI::InputManager
:iab Mmgl MyGUI::LogManager
:iab Mmglan MyGUI::LanguageManager
:iab Mmglaye MyGUI::LayerManager
:iab Mmglayo MyGUI::LayoutManager
:iab Mmgplu MyGUI::PluginManager
:iab Mmgpoi MyGUI::PointerManager
:iab Mmgren MyGUI::RenderManager
:iab Mmgres MyGUI::ResourceManager
:iab Mmgs MyGUI::SkinManager
:iab Mmgsw MyGUI::SubWidgetManager
:iab Mmgtt MyGUI::ToolTipManager
:iab Mmgw MyGUI::WidgetManager

"mygui singleton
:iab Msgcm MyGUI::ControllerManager::getSingleton()
:iab Msgcbm MyGUI::ClipboardManager::getSingleton()
:iab Msgdlm MyGUI::DynLibManager::getSingleton()
:iab Msgfm MyGUI::FontManager::getSingleton()
:iab Msgfacm MyGUI::FactoryManager::getSingleton()
:iab Msgim MyGUI::InputManager::getSingleton()
:iab Msglm MyGUI::LogManager::getSingleton()
:iab Msglanm MyGUI::LanguageManager::getSingleton()
:iab Msglayem MyGUI::LayerManager::getSingleton()
:iab Msglayom MyGUI::LayoutManager::getSingleton()
:iab Msgplum MyGUI::PluginManager::getSingleton()
:iab Msgpoim MyGUI::PointerManager::getSingleton()
:iab Msgrenm MyGUI::RenderManager::getSingleton()
:iab Msgresm MyGUI::ResourceManager::getSingleton()
:iab Msgsm MyGUI::SkinManager::getSingleton()
:iab Msgswm MyGUI::SubWidgetManager::getSingleton()
:iab Msgttm MyGUI::ToolTipManager::getSingleton()
:iab Msgwm MyGUI::WidgetManager::getSingleton()

"sdl2
:iab S SDL_
:iab Sk SDLK_

"cscope-----------------------------------------------------
"if has("cscope")
  "set csprg=/usr/bin/cscope
  ""search cscope databases before tag files
  "set csto=0
  ""use cstag instead of tag
  "set cst
  ""print message when adding a cscope database
  "set nocsverb
  ""use quickfix
  "set cscopequickfix=s-,c-,d-,i-,t-,e-
  "" add any database in current directory
  "if filereadable("cscope.out")
    "cs add cscope.out
    "" else add database pointed to by environment
  "elseif $CSCOPE_DB != ""
    "cs add $CSCOPE_DB
  "endif
  "set csverb
"endif

"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file
"nnoremap <Leader><Leader>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
"nnoremap <Leader><Leader>i :lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nnoremap <Leader><Leader>d :lcs find d <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cs :cs find s <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cg :cs find g <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cc :cs find c <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ct :cs find t <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ce :cs find e <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
"command! -nargs=0  Ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"command! -nargs=0  Cd :cs find d <C-R>=expand("<cword>")<CR><CR>

"check ctags --list-kind=c++ for detail
"Most of the time i need only functin declaration tags, i don't need function
"definition tags.
"command! -nargs=0 Cut :!ctags --c++-kinds=+p-f include/* src/*
