function abbre#glsl()
endfunction

function abbre#cpp()

  "boost  abbreviation

  " :iab <buffer> i8  int8_t
  " :iab <buffer> i16 int16_t
  " :iab <buffer> i32 int32_t
  " :iab <buffer> i64 int64_t
  " :iab <buffer> if8  int_fast8_t
  " :iab <buffer> if16 int_fast16_t
  " :iab <buffer> if32 int_fast32_t
  " :iab <buffer> if64 int_fast64_t
  " :iab <buffer> il8  int_least8_t
  " :iab <buffer> il16 int_least16_t
  " :iab <buffer> il32 int_least32_t
  " :iab <buffer> il64 int_least64_t
  " :iab <buffer> u8  uint8_t
  " :iab <buffer> u16 uint16_t
  " :iab <buffer> u32 uint32_t
  " :iab <buffer> u64 uint64_t
  " :iab <buffer> uf8  uint_fast8_t
  " :iab <buffer> uf16 uint_fast16_t
  " :iab <buffer> uf32 uint_fast32_t
  " :iab <buffer> uf64 uint_fast64_t
  " :iab <buffer> ul8  uint_least8_t
  " :iab <buffer> ul16 uint_least16_t
  " :iab <buffer> ul32 uint_least32_t
  " :iab <buffer> ul64 uint_least64_t
endfunction

function abbre#opengl()

  " auto generated from ctag
  :iab <buffer> gl2b GL_2_BYTES
  :iab <buffer> gl3b GL_3_BYTES
  :iab <buffer> gl3dc GL_3D_COLOR
  :iab <buffer> gl3dct GL_3D_COLOR_TEXTURE
  :iab <buffer> gl4b GL_4_BYTES
  :iab <buffer> gl4dct GL_4D_COLOR_TEXTURE
  " :iab <buffer> glaab GL_ACCUM_ALPHA_BITS
  :iab <buffer> glaab GL_ALL_ATTRIB_BITS
  :iab <buffer> glaacb GL_ACTIVE_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glaad GL_AMBIENT_AND_DIFFUSE
  :iab <buffer> glaa GL_ACTIVE_ATTRIBUTES
  :iab <buffer> glaaml GL_ACTIVE_ATTRIBUTE_MAX_LENGTH
  " :iab <buffer> glabb GL_ACCUM_BLUE_BITS
  " :iab <buffer> glabb GL_ACCUM_BUFFER_BIT
  " :iab <buffer> glabb GL_ALL_BARRIER_BITS
  :iab <buffer> glabb GL_ARRAY_BUFFER_BINDING
  " :iab <buffer> glab GL_ALPHA_BIAS
  " :iab <buffer> glab GL_ALPHA_BITS
  :iab <buffer> glab GL_ARRAY_BUFFER
  ":iab <buffer> glab GL_AUX_BUFFERS
  :iab <buffer> glacab GL_ALL_CLIENT_ATTRIB_BITS
  :iab <buffer> glacbaac GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS
  :iab <buffer> glacbaaci GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES
  " :iab <buffer> glacbb GL_ATOMIC_COUNTER_BARRIER_BIT
  :iab <buffer> glacbb GL_ATOMIC_COUNTER_BUFFER_BINDING
  :iab <buffer> glacbds GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE
  :iab <buffer> glacb GL_ATOMIC_COUNTER_BUFFER
  :iab <buffer> glacbi GL_ATOMIC_COUNTER_BUFFER_INDEX
  :iab <buffer> glacbrbcs GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER
  :iab <buffer> glacbrbfs GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER
  :iab <buffer> glacbrbgs GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER
  :iab <buffer> glacbrbtcs GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER
  :iab <buffer> glacbrbtes GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER
  :iab <buffer> glacbrbvs GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER
  " :iab <buffer> glacbs GL_ATOMIC_COUNTER_BUFFER_SIZE
  :iab <buffer> glacbs GL_ATOMIC_COUNTER_BUFFER_START
  :iab <buffer> glacv GL_ACCUM_CLEAR_VALUE
  :iab <buffer> glagb GL_ACCUM_GREEN_BITS
  :iab <buffer> glagm GL_AUTO_GENERATE_MIPMAP
  " :iab <buffer> glai GL_ALPHA_INTEGER
  :iab <buffer> glai GL_AND_INVERTED
  :iab <buffer> glalwr GL_ALIASED_LINE_WIDTH_RANGE
  :iab <buffer> glan GL_AUTO_NORMAL
  :iab <buffer> glap GL_ACTIVE_PROGRAM
  :iab <buffer> glapsr GL_ALIASED_POINT_SIZE_RANGE
  :iab <buffer> glarb GL_ACCUM_RED_BITS
  " :iab <buffer> glar GL_ACTIVE_RESOURCES
  :iab <buffer> glar GL_AND_REVERSE
  :iab <buffer> glasb GL_ALL_SHADER_BITS
  :iab <buffer> glasd GL_ATTRIB_STACK_DEPTH
  " :iab <buffer> glas GL_ACTIVE_SUBROUTINES
  " :iab <buffer> glas GL_ADD_SIGNED
  " :iab <buffer> glas GL_ALPHA_SCALE
  " :iab <buffer> glas GL_ALREADY_SIGNALED
  " :iab <buffer> glas GL_ARRAY_SIZE
  " :iab <buffer> glas GL_ARRAY_STRIDE
  :iab <buffer> glas GL_ATTACHED_SHADERS
  :iab <buffer> glasml GL_ACTIVE_SUBROUTINE_MAX_LENGTH
  :iab <buffer> glaspc GL_ANY_SAMPLES_PASSED_CONSERVATIVE
  :iab <buffer> glasp GL_ANY_SAMPLES_PASSED
  :iab <buffer> glasu GL_ACTIVE_SUBROUTINE_UNIFORMS
  :iab <buffer> glasul GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS
  :iab <buffer> glasuml GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH
  :iab <buffer> glatf GL_ALPHA_TEST_FUNC
  " :iab <buffer> glat GL_ACTIVE_TEXTURE
  :iab <buffer> glat GL_ALPHA_TEST
  :iab <buffer> glatr GL_ALPHA_TEST_REF
  :iab <buffer> glaub GL_ACTIVE_UNIFORM_BLOCKS
  :iab <buffer> glaubmnl GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH
  :iab <buffer> glau GL_ACTIVE_UNIFORMS
  :iab <buffer> glauml GL_ACTIVE_UNIFORM_MAX_LENGTH
  :iab <buffer> glav GL_ACTIVE_VARIABLES
  :iab <buffer> glbaf GL_BUFFER_ACCESS_FLAGS
  :iab <buffer> glba GL_BUFFER_ACCESS
  " :iab <buffer> glbb GL_BLUE_BIAS
  " :iab <buffer> glbb GL_BLUE_BITS
  :iab <buffer> glbb GL_BUFFER_BINDING
  :iab <buffer> glbc GL_BLEND_COLOR
  :iab <buffer> glbda GL_BLEND_DST_ALPHA
  :iab <buffer> glbd GL_BLEND_DST
  :iab <buffer> glbdr GL_BLEND_DST_RGB
  :iab <buffer> glbds GL_BUFFER_DATA_SIZE
  :iab <buffer> glbea GL_BLEND_EQUATION_ALPHA
  :iab <buffer> glbe GL_BLEND_EQUATION
  :iab <buffer> glber GL_BLEND_EQUATION_RGB
  " :iab <buffer> glbi GL_BGRA_INTEGER
  " :iab <buffer> glbi GL_BGR_INTEGER
  " :iab <buffer> glbi GL_BLOCK_INDEX
  :iab <buffer> glbi GL_BLUE_INTEGER
  :iab <buffer> glbis GL_BUFFER_IMMUTABLE_STORAGE
  :iab <buffer> glbl GL_BACK_LEFT
  :iab <buffer> glbm GL_BUFFER_MAPPED
  :iab <buffer> glbml GL_BUFFER_MAP_LENGTH
  :iab <buffer> glbmo GL_BUFFER_MAP_OFFSET
  :iab <buffer> glbmp GL_BUFFER_MAP_POINTER
  :iab <buffer> glbr GL_BACK_RIGHT
  :iab <buffer> glbsa GL_BLEND_SRC_ALPHA
  :iab <buffer> glbsf GL_BUFFER_STORAGE_FLAGS
  " :iab <buffer> glbs GL_BLEND_SRC
  " :iab <buffer> glbs GL_BLUE_SCALE
  :iab <buffer> glbs GL_BUFFER_SIZE
  :iab <buffer> glbsr GL_BLEND_SRC_RGB
  :iab <buffer> glbt GL_BITMAP_TOKEN
  :iab <buffer> glbubb GL_BUFFER_UPDATE_BARRIER_BIT
  :iab <buffer> glbu GL_BUFFER_USAGE
  :iab <buffer> glbv2 GL_BOOL_VEC2
  :iab <buffer> glbv3 GL_BOOL_VEC3
  :iab <buffer> glbv4 GL_BOOL_VEC4
  :iab <buffer> glbv GL_BUFFER_VARIABLE
  :iab <buffer> glc1d GL_CONVOLUTION_1D
  :iab <buffer> glc2d GL_CONVOLUTION_2D
  :iab <buffer> glc3fv3f GL_C3F_V3F
  :iab <buffer> glc4fn3fv3f GL_C4F_N3F_V3F
  :iab <buffer> glc4ubv2f GL_C4UB_V2F
  :iab <buffer> glc4ubv3f GL_C4UB_V3F
  :iab <buffer> glca0 GL_COLOR_ATTACHMENT0
  :iab <buffer> glca10 GL_COLOR_ATTACHMENT10
  :iab <buffer> glca11 GL_COLOR_ATTACHMENT11
  :iab <buffer> glca12 GL_COLOR_ATTACHMENT12
  :iab <buffer> glca13 GL_COLOR_ATTACHMENT13
  :iab <buffer> glca14 GL_COLOR_ATTACHMENT14
  :iab <buffer> glca15 GL_COLOR_ATTACHMENT15
  :iab <buffer> glca16 GL_COLOR_ATTACHMENT16
  :iab <buffer> glca17 GL_COLOR_ATTACHMENT17
  :iab <buffer> glca18 GL_COLOR_ATTACHMENT18
  :iab <buffer> glca19 GL_COLOR_ATTACHMENT19
  :iab <buffer> glca1 GL_COLOR_ATTACHMENT1
  :iab <buffer> glca20 GL_COLOR_ATTACHMENT20
  :iab <buffer> glca21 GL_COLOR_ATTACHMENT21
  :iab <buffer> glca22 GL_COLOR_ATTACHMENT22
  :iab <buffer> glca23 GL_COLOR_ATTACHMENT23
  :iab <buffer> glca24 GL_COLOR_ATTACHMENT24
  :iab <buffer> glca25 GL_COLOR_ATTACHMENT25
  :iab <buffer> glca26 GL_COLOR_ATTACHMENT26
  :iab <buffer> glca27 GL_COLOR_ATTACHMENT27
  :iab <buffer> glca28 GL_COLOR_ATTACHMENT28
  :iab <buffer> glca29 GL_COLOR_ATTACHMENT29
  :iab <buffer> glca2 GL_COLOR_ATTACHMENT2
  :iab <buffer> glca30 GL_COLOR_ATTACHMENT30
  :iab <buffer> glca31 GL_COLOR_ATTACHMENT31
  :iab <buffer> glca3 GL_COLOR_ATTACHMENT3
  :iab <buffer> glca4 GL_COLOR_ATTACHMENT4
  :iab <buffer> glca5 GL_COLOR_ATTACHMENT5
  :iab <buffer> glca6 GL_COLOR_ATTACHMENT6
  :iab <buffer> glca7 GL_COLOR_ATTACHMENT7
  :iab <buffer> glca8 GL_COLOR_ATTACHMENT8
  :iab <buffer> glca9 GL_COLOR_ATTACHMENT9
  :iab <buffer> glcaab GL_CLIENT_ALL_ATTRIB_BITS
  :iab <buffer> glcabb GL_COLOR_ARRAY_BUFFER_BINDING
  :iab <buffer> glcae GL_COMPILE_AND_EXECUTE
  " :iab <buffer> glca GL_COLOR_ARRAY
  " :iab <buffer> glca GL_COMBINE_ALPHA
  " :iab <buffer> glca GL_COMPRESSED_ALPHA
  " :iab <buffer> glca GL_CONSTANT_ALPHA
  :iab <buffer> glca GL_CONSTANT_ATTENUATION
  :iab <buffer> glcap GL_COLOR_ARRAY_POINTER
  :iab <buffer> glcasd GL_CLIENT_ATTRIB_STACK_DEPTH
  " :iab <buffer> glcas GL_COLOR_ARRAY_SIZE
  :iab <buffer> glcas GL_COLOR_ARRAY_STRIDE
  " :iab <buffer> glcat GL_CLIENT_ACTIVE_TEXTURE
  :iab <buffer> glcat GL_COLOR_ARRAY_TYPE
  :iab <buffer> glcbb GL_COLOR_BUFFER_BIT
  ":iab <buffer> glcbb GL_COMMAND_BARRIER_BIT
  :iab <buffer> glcbc GL_CONVOLUTION_BORDER_COLOR
  " :iab <buffer> glcb GL_CLEAR_BUFFER
  " :iab <buffer> glcb GL_CONSTANT_BORDER
  :iab <buffer> glcb GL_CURRENT_BIT
  :iab <buffer> glcbm GL_CONVOLUTION_BORDER_MODE
  " :iab <buffer> glcc GL_COLOR_COMPONENTS
  " :iab <buffer> glcc GL_CONSTANT_COLOR
  :iab <buffer> glcc GL_CURRENT_COLOR
  " :iab <buffer> glccpb GL_CONTEXT_COMPATIBILITY_PROFILE_BIT
  :iab <buffer> glccpb GL_CONTEXT_CORE_PROFILE_BIT
  :iab <buffer> glccv GL_COLOR_CLEAR_VALUE
  :iab <buffer> glcd0 GL_CLIP_DISTANCE0
  :iab <buffer> glcd1 GL_CLIP_DISTANCE1
  :iab <buffer> glcd2 GL_CLIP_DISTANCE2
  :iab <buffer> glcd3 GL_CLIP_DISTANCE3
  :iab <buffer> glcd4 GL_CLIP_DISTANCE4
  :iab <buffer> glcd5 GL_CLIP_DISTANCE5
  :iab <buffer> glcd6 GL_CLIP_DISTANCE6
  :iab <buffer> glcd7 GL_CLIP_DISTANCE7
  :iab <buffer> glcdm GL_CLIP_DEPTH_MODE
  :iab <buffer> glce GL_COLOR_ENCODING
  :iab <buffer> glcfb GL_CONVOLUTION_FILTER_BIAS
  " :iab <buffer> glcfc GL_CLAMP_FRAGMENT_COLOR
  " :iab <buffer> glcfc GL_CURRENT_FOG_COORD
  :iab <buffer> glcfc GL_CURRENT_FOG_COORDINATE
  :iab <buffer> glcfdb GL_CONTEXT_FLAG_DEBUG_BIT
  :iab <buffer> glcffcb GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT
  " :iab <buffer> glcf GL_CONTEXT_FLAGS
  " :iab <buffer> glcf GL_CONVOLUTION_FORMAT
  :iab <buffer> glcf GL_CULL_FACE
  :iab <buffer> glcfm GL_CULL_FACE_MODE
  :iab <buffer> glcfneb GL_CONTEXT_FLAG_NO_ERROR_BIT
  :iab <buffer> glcfrab GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT
  :iab <buffer> glcfs GL_CONVOLUTION_FILTER_SCALE
  :iab <buffer> glch GL_CONVOLUTION_HEIGHT
  " :iab <buffer> glci GL_COLOR_INDEX
  " :iab <buffer> glci GL_COLOR_INDEXES
  " :iab <buffer> glci GL_COMPRESSED_INTENSITY
  " :iab <buffer> glci GL_COPY_INVERTED
  :iab <buffer> glci GL_CURRENT_INDEX
  :iab <buffer> glcip GL_CLIPPING_INPUT_PRIMITIVES
  :iab <buffer> glcla GL_COMPRESSED_LUMINANCE_ALPHA
  " :iab <buffer> glcl GL_COMPRESSED_LUMINANCE
  :iab <buffer> glcl GL_CONTEXT_LOST
  :iab <buffer> glclo GL_COLOR_LOGIC_OP
  :iab <buffer> glcmbbb GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT
  :iab <buffer> glcmf GL_COLOR_MATERIAL_FACE
  " :iab <buffer> glcm GL_COLOR_MATERIAL
  :iab <buffer> glcm GL_COLOR_MATRIX
  :iab <buffer> glcmp GL_COLOR_MATERIAL_PARAMETER
  :iab <buffer> glcmsd GL_COLOR_MATRIX_STACK_DEPTH
  :iab <buffer> glcn GL_CURRENT_NORMAL
  :iab <buffer> glco GL_CLIP_ORIGIN
  :iab <buffer> glcop GL_CLIPPING_OUTPUT_PRIMITIVES
  :iab <buffer> glcp0 GL_CLIP_PLANE0
  :iab <buffer> glcp1 GL_CLIP_PLANE1
  :iab <buffer> glcp2 GL_CLIP_PLANE2
  :iab <buffer> glcp3 GL_CLIP_PLANE3
  :iab <buffer> glcp4 GL_CLIP_PLANE4
  :iab <buffer> glcp5 GL_CLIP_PLANE5
  :iab <buffer> glcp GL_CURRENT_PROGRAM
  :iab <buffer> glcpm GL_CONTEXT_PROFILE_MASK
  :iab <buffer> glcpsb GL_CLIENT_PIXEL_STORE_BIT
  :iab <buffer> glcpt GL_COPY_PIXEL_TOKEN
  :iab <buffer> glcq GL_CURRENT_QUERY
  " :iab <buffer> glcr11e GL_COMPRESSED_R11_EAC
  :iab <buffer> glcr11e GL_COMPRESSED_RG11_EAC
  :iab <buffer> glcr8e2e GL_COMPRESSED_RGBA8_ETC2_EAC
  :iab <buffer> glcr8e2 GL_COMPRESSED_RGB8_ETC2
  :iab <buffer> glcr8pa1e2 GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2
  :iab <buffer> glcra GL_CONTEXT_ROBUST_ACCESS
  :iab <buffer> glcrbb GL_COPY_READ_BUFFER_BINDING
  :iab <buffer> glcrbf GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH
  " :iab <buffer> glcrb GL_CONTEXT_RELEASE_BEHAVIOR
  :iab <buffer> glcrb GL_COPY_READ_BUFFER
  :iab <buffer> glcrbsf GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT
  :iab <buffer> glcrbuf GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT
  :iab <buffer> glcrbu GL_COMPRESSED_RGBA_BPTC_UNORM
  " :iab <buffer> glcrc GL_CLAMP_READ_COLOR
  :iab <buffer> glcrc GL_CURRENT_RASTER_COLOR
  :iab <buffer> glcrd GL_CURRENT_RASTER_DISTANCE
  " :iab <buffer> glcr GL_COLOR_RENDERABLE
  " :iab <buffer> glcr GL_COMBINE_RGB
  " :iab <buffer> glcr GL_COMPRESSED_RED
  " :iab <buffer> glcr GL_COMPRESSED_RG
  " :iab <buffer> glcr GL_COMPRESSED_RGB
  " :iab <buffer> glcr GL_COMPRESSED_RGBA
  :iab <buffer> glcr GL_COORD_REPLACE
  :iab <buffer> glcri GL_CURRENT_RASTER_INDEX
  :iab <buffer> glcrp GL_CURRENT_RASTER_POSITION
  :iab <buffer> glcrpv GL_CURRENT_RASTER_POSITION_VALID
  :iab <buffer> glcrr1 GL_COMPRESSED_RED_RGTC1
  :iab <buffer> glcrr2 GL_COMPRESSED_RG_RGTC2
  :iab <buffer> glcrsc GL_CURRENT_RASTER_SECONDARY_COLOR
  :iab <buffer> glcrtc GL_CURRENT_RASTER_TEXTURE_COORDS
  " :iab <buffer> glcrtt GL_COMPARE_REF_TO_TEXTURE
  :iab <buffer> glcrtt GL_COMPARE_R_TO_TEXTURE
  :iab <buffer> glcs8a8e2e GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC
  :iab <buffer> glcs8e2 GL_COMPRESSED_SRGB8_ETC2
  :iab <buffer> glcs8pa1e2 GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2
  :iab <buffer> glcsabu GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM
  " :iab <buffer> glcsa GL_COMPRESSED_SLUMINANCE_ALPHA
  :iab <buffer> glcsa GL_COMPRESSED_SRGB_ALPHA
  " :iab <buffer> glcsb GL_CLIENT_STORAGE_BIT
  :iab <buffer> glcsb GL_COMPUTE_SHADER_BIT
  :iab <buffer> glcsc GL_CURRENT_SECONDARY_COLOR
  " :iab <buffer> glcs GL_CAVEAT_SUPPORT
  " :iab <buffer> glcs GL_COLOR_SUM
  " :iab <buffer> glcs GL_COMPATIBLE_SUBROUTINES
  " :iab <buffer> glcs GL_COMPILE_STATUS
  " :iab <buffer> glcs GL_COMPRESSED_SLUMINANCE
  " :iab <buffer> glcs GL_COMPRESSED_SRGB
  " :iab <buffer> glcs GL_COMPUTE_SHADER
  " :iab <buffer> glcs GL_COMPUTE_SUBROUTINE
  :iab <buffer> glcs GL_CONDITION_SATISFIED
  :iab <buffer> glcsi GL_COMPUTE_SHADER_INVOCATIONS
  " :iab <buffer> glcsr11e GL_COMPRESSED_SIGNED_R11_EAC
  :iab <buffer> glcsr11e GL_COMPRESSED_SIGNED_RG11_EAC
  :iab <buffer> glcsrr1 GL_COMPRESSED_SIGNED_RED_RGTC1
  :iab <buffer> glcsrr2 GL_COMPRESSED_SIGNED_RG_RGTC2
  :iab <buffer> glcsu GL_COMPUTE_SUBROUTINE_UNIFORM
  :iab <buffer> glctas GL_COLOR_TABLE_ALPHA_SIZE
  " :iab <buffer> glctb GL_CLAMP_TO_BORDER
  :iab <buffer> glctb GL_COLOR_TABLE_BIAS
  :iab <buffer> glctbs GL_COLOR_TABLE_BLUE_SIZE
  :iab <buffer> glctc GL_CURRENT_TEXTURE_COORDS
  :iab <buffer> glcte GL_CLAMP_TO_EDGE
  " :iab <buffer> glctf GL_COLOR_TABLE_FORMAT
  :iab <buffer> glctf GL_COMPRESSED_TEXTURE_FORMATS
  " :iab <buffer> glct GL_CLEAR_TEXTURE
  " :iab <buffer> glct GL_COLOR_TABLE
  :iab <buffer> glct GL_COMPUTE_TEXTURE
  :iab <buffer> glctgs GL_COLOR_TABLE_GREEN_SIZE
  :iab <buffer> glctis GL_COLOR_TABLE_INTENSITY_SIZE
  :iab <buffer> glctls GL_COLOR_TABLE_LUMINANCE_SIZE
  :iab <buffer> glctrs GL_COLOR_TABLE_RED_SIZE
  :iab <buffer> glcts GL_COLOR_TABLE_SCALE
  :iab <buffer> glctw GL_COLOR_TABLE_WIDTH
  :iab <buffer> glcvab GL_CLIENT_VERTEX_ARRAY_BIT
  :iab <buffer> glcva GL_CURRENT_VERTEX_ATTRIB
  :iab <buffer> glcvc GL_CLAMP_VERTEX_COLOR
  :iab <buffer> glcwbb GL_COPY_WRITE_BUFFER_BINDING
  :iab <buffer> glcwb GL_COPY_WRITE_BUFFER
  " :iab <buffer> glcw GL_COLOR_WRITEMASK
  :iab <buffer> glcw GL_CONVOLUTION_WIDTH
  :iab <buffer> glcwgs GL_COMPUTE_WORK_GROUP_SIZE
  :iab <buffer> gld24s8 GL_DEPTH24_STENCIL8
  " :iab <buffer> gld3r GL_DOT3_RGB
  :iab <buffer> gld3r GL_DOT3_RGBA
  " :iab <buffer> glda GL_DEPTH_ATTACHMENT
  :iab <buffer> glda GL_DST_ALPHA
  :iab <buffer> gldb0 GL_DRAW_BUFFER0
  :iab <buffer> gldb10 GL_DRAW_BUFFER10
  :iab <buffer> gldb11 GL_DRAW_BUFFER11
  :iab <buffer> gldb12 GL_DRAW_BUFFER12
  :iab <buffer> gldb13 GL_DRAW_BUFFER13
  :iab <buffer> gldb14 GL_DRAW_BUFFER14
  :iab <buffer> gldb15 GL_DRAW_BUFFER15
  :iab <buffer> gldb1 GL_DRAW_BUFFER1
  :iab <buffer> gldb2 GL_DRAW_BUFFER2
  :iab <buffer> gldb3 GL_DRAW_BUFFER3
  :iab <buffer> gldb4 GL_DRAW_BUFFER4
  :iab <buffer> gldb5 GL_DRAW_BUFFER5
  :iab <buffer> gldb6 GL_DRAW_BUFFER6
  :iab <buffer> gldb7 GL_DRAW_BUFFER7
  :iab <buffer> gldb8 GL_DRAW_BUFFER8
  :iab <buffer> gldb9 GL_DRAW_BUFFER9
  :iab <buffer> gldbb GL_DEPTH_BUFFER_BIT
  " :iab <buffer> gldb GL_DEPTH_BIAS
  " :iab <buffer> gldb GL_DEPTH_BITS
  :iab <buffer> gldb GL_DRAW_BUFFER
  :iab <buffer> gldc16 GL_DEPTH_COMPONENT16
  :iab <buffer> gldc24 GL_DEPTH_COMPONENT24
  :iab <buffer> gldc32 GL_DEPTH_COMPONENT32
  :iab <buffer> gldcf GL_DEBUG_CALLBACK_FUNCTION
  " :iab <buffer> gldc GL_DEPTH_CLAMP
  " :iab <buffer> gldc GL_DEPTH_COMPONENT
  " :iab <buffer> gldc GL_DEPTH_COMPONENTS
  " :iab <buffer> gldc GL_DONT_CARE
  " :iab <buffer> gldc GL_DST_COLOR
  :iab <buffer> gldc GL_DYNAMIC_COPY
  :iab <buffer> gldcomponent32f GL_DEPTH_COMPONENT32F
  :iab <buffer> gldcup GL_DEBUG_CALLBACK_USER_PARAM
  :iab <buffer> gldcv GL_DEPTH_CLEAR_VALUE
  :iab <buffer> gldd GL_DYNAMIC_DRAW
  :iab <buffer> gldepth32fs8 GL_DEPTH32F_STENCIL8
  :iab <buffer> gldfb GL_DRAW_FRAMEBUFFER_BINDING
  " :iab <buffer> gldf GL_DEPTH_FUNC
  :iab <buffer> gldf GL_DRAW_FRAMEBUFFER
  :iab <buffer> gldgsd GL_DEBUG_GROUP_STACK_DEPTH
  " :iab <buffer> gldibb GL_DISPATCH_INDIRECT_BUFFER_BINDING
  :iab <buffer> gldibb GL_DRAW_INDIRECT_BUFFER_BINDING
  " :iab <buffer> gldib GL_DISPATCH_INDIRECT_BUFFER
  :iab <buffer> gldib GL_DRAW_INDIRECT_BUFFER
  :iab <buffer> gldl GL_DISPLAY_LIST
  :iab <buffer> gldlm GL_DEBUG_LOGGED_MESSAGES
  :iab <buffer> gldm2 GL_DOUBLE_MAT2
  :iab <buffer> gldm3 GL_DOUBLE_MAT3
  :iab <buffer> gldm4 GL_DOUBLE_MAT4
  :iab <buffer> gldmat2x3 GL_DOUBLE_MAT2x3
  :iab <buffer> gldmat2x4 GL_DOUBLE_MAT2x4
  :iab <buffer> gldmat3x2 GL_DOUBLE_MAT3x2
  :iab <buffer> gldmat3x4 GL_DOUBLE_MAT3x4
  :iab <buffer> gldmat4x2 GL_DOUBLE_MAT4x2
  :iab <buffer> gldmat4x3 GL_DOUBLE_MAT4x3
  :iab <buffer> gldnlml GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH
  :iab <buffer> gldo GL_DEBUG_OUTPUT
  :iab <buffer> gldos GL_DEBUG_OUTPUT_SYNCHRONOUS
  :iab <buffer> gldpt GL_DRAW_PIXEL_TOKEN
  " :iab <buffer> gldr GL_DEPTH_RANGE
  " :iab <buffer> gldr GL_DEPTH_RENDERABLE
  :iab <buffer> gldr GL_DYNAMIC_READ
  " :iab <buffer> gldsa GL_DEBUG_SOURCE_API
  " :iab <buffer> gldsa GL_DEBUG_SOURCE_APPLICATION
  :iab <buffer> gldsa GL_DEPTH_STENCIL_ATTACHMENT
  :iab <buffer> gldsb GL_DYNAMIC_STORAGE_BIT
  " :iab <buffer> glds GL_DELETE_STATUS
  " :iab <buffer> glds GL_DEPTH_SCALE
  :iab <buffer> glds GL_DEPTH_STENCIL
  :iab <buffer> gldsh GL_DEBUG_SEVERITY_HIGH
  :iab <buffer> gldsl GL_DEBUG_SEVERITY_LOW
  :iab <buffer> gldsm GL_DEBUG_SEVERITY_MEDIUM
  :iab <buffer> gldsn GL_DEBUG_SEVERITY_NOTIFICATION
  :iab <buffer> gldso GL_DEBUG_SOURCE_OTHER
  :iab <buffer> gldssc GL_DEBUG_SOURCE_SHADER_COMPILER
  :iab <buffer> gldstm GL_DEPTH_STENCIL_TEXTURE_MODE
  :iab <buffer> gldstp GL_DEBUG_SOURCE_THIRD_PARTY
  :iab <buffer> gldsws GL_DEBUG_SOURCE_WINDOW_SYSTEM
  :iab <buffer> gldtdb GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR
  :iab <buffer> gldte GL_DEBUG_TYPE_ERROR
  :iab <buffer> gldt GL_DEPTH_TEST
  " :iab <buffer> gldtm GL_DEBUG_TYPE_MARKER
  :iab <buffer> gldtm GL_DEPTH_TEXTURE_MODE
  :iab <buffer> gldto GL_DEBUG_TYPE_OTHER
  " :iab <buffer> gldtpg GL_DEBUG_TYPE_POP_GROUP
  :iab <buffer> gldtpg GL_DEBUG_TYPE_PUSH_GROUP
  " :iab <buffer> gldtp GL_DEBUG_TYPE_PERFORMANCE
  :iab <buffer> gldtp GL_DEBUG_TYPE_PORTABILITY
  :iab <buffer> gldtub GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR
  :iab <buffer> gldv2 GL_DOUBLE_VEC2
  :iab <buffer> gldv3 GL_DOUBLE_VEC3
  :iab <buffer> gldv4 GL_DOUBLE_VEC4
  " :iab <buffer> gldw GL_DECR_WRAP
  :iab <buffer> gldw GL_DEPTH_WRITEMASK
  " :iab <buffer> gleabb GL_ELEMENT_ARRAY_BARRIER_BIT
  :iab <buffer> gleabb GL_ELEMENT_ARRAY_BUFFER_BINDING
  :iab <buffer> gleab GL_ELEMENT_ARRAY_BUFFER
  " :iab <buffer> gleb GL_ENABLE_BIT
  :iab <buffer> gleb GL_EVAL_BIT
  :iab <buffer> glefabb GL_EDGE_FLAG_ARRAY_BUFFER_BINDING
  :iab <buffer> glefa GL_EDGE_FLAG_ARRAY
  :iab <buffer> glefap GL_EDGE_FLAG_ARRAY_POINTER
  :iab <buffer> glefas GL_EDGE_FLAG_ARRAY_STRIDE
  :iab <buffer> glef GL_EDGE_FLAG
  :iab <buffer> glel GL_EYE_LINEAR
  :iab <buffer> glep GL_EYE_PLANE
  :iab <buffer> glf32ui248r GL_FLOAT_32_UNSIGNED_INT_24_8_REV
  :iab <buffer> glfaas GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE
  :iab <buffer> glfab GL_FRONT_AND_BACK
  :iab <buffer> glfabs GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE
  :iab <buffer> glface GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING
  :iab <buffer> glfact GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE
  :iab <buffer> glfads GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE
  :iab <buffer> glfa GL_FUNC_ADD
  :iab <buffer> glfags GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE
  :iab <buffer> glfal GL_FRAMEBUFFER_ATTACHMENT_LAYERED
  :iab <buffer> glfaon GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME
  :iab <buffer> glfaot GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE
  :iab <buffer> glfars GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE
  :iab <buffer> glfass GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE
  :iab <buffer> glfatcmf GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE
  " :iab <buffer> glfatl GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER
  :iab <buffer> glfatl GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL
  :iab <buffer> glfbb GL_FRAMEBUFFER_BARRIER_BIT
  " :iab <buffer> glfb GL_FOG_BIT
  " :iab <buffer> glfb GL_FRAMEBUFFER_BINDING
  :iab <buffer> glfb GL_FRAMEBUFFER_BLEND
  :iab <buffer> glfbp GL_FEEDBACK_BUFFER_POINTER
  :iab <buffer> glfbs GL_FEEDBACK_BUFFER_SIZE
  :iab <buffer> glfbt GL_FEEDBACK_BUFFER_TYPE
  " :iab <buffer> glfcabb GL_FOG_COORD_ARRAY_BUFFER_BINDING
  :iab <buffer> glfcabb GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING
  " :iab <buffer> glfca GL_FOG_COORD_ARRAY
  :iab <buffer> glfca GL_FOG_COORDINATE_ARRAY
  " :iab <buffer> glfcap GL_FOG_COORD_ARRAY_POINTER
  :iab <buffer> glfcap GL_FOG_COORDINATE_ARRAY_POINTER
  " :iab <buffer> glfcas GL_FOG_COORD_ARRAY_STRIDE
  :iab <buffer> glfcas GL_FOG_COORDINATE_ARRAY_STRIDE
  " :iab <buffer> glfcat GL_FOG_COORD_ARRAY_TYPE
  :iab <buffer> glfcat GL_FOG_COORDINATE_ARRAY_TYPE
  " :iab <buffer> glfc GL_FOG_COLOR
  " :iab <buffer> glfc GL_FOG_COORD
  " :iab <buffer> glfc GL_FOG_COORDINATE
  :iab <buffer> glfc GL_FRAMEBUFFER_COMPLETE
  " :iab <buffer> glfcs GL_FOG_COORDINATE_SOURCE
  :iab <buffer> glfcs GL_FOG_COORD_SRC
  :iab <buffer> glfdfsl GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS
  " :iab <buffer> glfd GL_FOG_DENSITY
  " :iab <buffer> glfd GL_FRAGMENT_DEPTH
  :iab <buffer> glfd GL_FRAMEBUFFER_DEFAULT
  :iab <buffer> glfdh GL_FRAMEBUFFER_DEFAULT_HEIGHT
  :iab <buffer> glfdl GL_FRAMEBUFFER_DEFAULT_LAYERS
  :iab <buffer> glfds GL_FRAMEBUFFER_DEFAULT_SAMPLES
  :iab <buffer> glfdw GL_FRAMEBUFFER_DEFAULT_WIDTH
  " :iab <buffer> glfe GL_FOG_END
  :iab <buffer> glfe GL_FRACTIONAL_EVEN
  :iab <buffer> glff GL_FRONT_FACE
  :iab <buffer> glfh GL_FOG_HINT
  :iab <buffer> glfia GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
  :iab <buffer> glfidb GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER
  :iab <buffer> glfi GL_FOG_INDEX
  :iab <buffer> glfilt GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS
  :iab <buffer> glfima GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
  :iab <buffer> glfim GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE
  :iab <buffer> glfiob GL_FRAGMENT_INTERPOLATION_OFFSET_BITS
  :iab <buffer> glfirb GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER
  :iab <buffer> glfl GL_FRONT_LEFT
  :iab <buffer> glfm2 GL_FLOAT_MAT2
  :iab <buffer> glfm3 GL_FLOAT_MAT3
  :iab <buffer> glfm4 GL_FLOAT_MAT4
  :iab <buffer> glfmat2x3 GL_FLOAT_MAT2x3
  :iab <buffer> glfmat2x4 GL_FLOAT_MAT2x4
  :iab <buffer> glfmat3x2 GL_FLOAT_MAT3x2
  :iab <buffer> glfmat3x4 GL_FLOAT_MAT3x4
  :iab <buffer> glfmat4x2 GL_FLOAT_MAT4x2
  :iab <buffer> glfmat4x3 GL_FLOAT_MAT4x3
  :iab <buffer> glfm GL_FOG_MODE
  " :iab <buffer> glfo GL_FIXED_ONLY
  :iab <buffer> glfo GL_FRACTIONAL_ODD
  " :iab <buffer> glfr GL_FRAMEBUFFER_RENDERABLE
  :iab <buffer> glfr GL_FRONT_RIGHT
  :iab <buffer> glfrl GL_FRAMEBUFFER_RENDERABLE_LAYERED
  :iab <buffer> glfrs GL_FUNC_REVERSE_SUBTRACT
  :iab <buffer> glfsb GL_FRAGMENT_SHADER_BIT
  :iab <buffer> glfsdh GL_FRAGMENT_SHADER_DERIVATIVE_HINT
  " :iab <buffer> glfs GL_FOG_START
  " :iab <buffer> glfs GL_FRAGMENT_SHADER
  " :iab <buffer> glfs GL_FRAGMENT_SUBROUTINE
  " :iab <buffer> glfs GL_FRAMEBUFFER_SRGB
  " :iab <buffer> glfs GL_FULL_SUPPORT
  :iab <buffer> glfs GL_FUNC_SUBTRACT
  :iab <buffer> glfsi GL_FRAGMENT_SHADER_INVOCATIONS
  :iab <buffer> glfsu GL_FRAGMENT_SUBROUTINE_UNIFORM
  :iab <buffer> glft GL_FRAGMENT_TEXTURE
  " :iab <buffer> glfu GL_FRAMEBUFFER_UNDEFINED
  :iab <buffer> glfu GL_FRAMEBUFFER_UNSUPPORTED
  :iab <buffer> glfv2 GL_FLOAT_VEC2
  :iab <buffer> glfv3 GL_FLOAT_VEC3
  :iab <buffer> glfv4 GL_FLOAT_VEC4
  :iab <buffer> glfvc GL_FIRST_VERTEX_CONVENTION
  " :iab <buffer> glgb GL_GREEN_BIAS
  :iab <buffer> glgb GL_GREEN_BITS
  :iab <buffer> glgcr GL_GUILTY_CONTEXT_RESET
  :iab <buffer> glgi GL_GREEN_INTEGER
  :iab <buffer> glgit GL_GEOMETRY_INPUT_TYPE
  :iab <buffer> glgm GL_GENERATE_MIPMAP
  :iab <buffer> glgmh GL_GENERATE_MIPMAP_HINT
  :iab <buffer> glgot GL_GEOMETRY_OUTPUT_TYPE
  :iab <buffer> glgsb GL_GEOMETRY_SHADER_BIT
  " :iab <buffer> glgs GL_GEOMETRY_SHADER
  " :iab <buffer> glgs GL_GEOMETRY_SUBROUTINE
  :iab <buffer> glgs GL_GREEN_SCALE
  :iab <buffer> glgsi GL_GEOMETRY_SHADER_INVOCATIONS
  :iab <buffer> glgspe GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED
  :iab <buffer> glgsu GL_GEOMETRY_SUBROUTINE_UNIFORM
  :iab <buffer> glgt GL_GEOMETRY_TEXTURE
  :iab <buffer> glgtif GL_GET_TEXTURE_IMAGE_FORMAT
  :iab <buffer> glgtit GL_GET_TEXTURE_IMAGE_TYPE
  :iab <buffer> glgvo GL_GEOMETRY_VERTICES_OUT
  :iab <buffer> glhas GL_HISTOGRAM_ALPHA_SIZE
  :iab <buffer> glhb GL_HINT_BIT
  :iab <buffer> glhbs GL_HISTOGRAM_BLUE_SIZE
  " :iab <buffer> glhf GL_HALF_FLOAT
  " :iab <buffer> glhf GL_HIGH_FLOAT
  :iab <buffer> glhf GL_HISTOGRAM_FORMAT
  :iab <buffer> glhgs GL_HISTOGRAM_GREEN_SIZE
  :iab <buffer> glhi GL_HIGH_INT
  :iab <buffer> glhls GL_HISTOGRAM_LUMINANCE_SIZE
  :iab <buffer> glhrs GL_HISTOGRAM_RED_SIZE
  :iab <buffer> glhs GL_HISTOGRAM_SINK
  :iab <buffer> glhw GL_HISTOGRAM_WIDTH
  :iab <buffer> gli1da GL_IMAGE_1D_ARRAY
  :iab <buffer> gli1d GL_IMAGE_1D
  :iab <buffer> gli2101010r GL_INT_2_10_10_10_REV
  :iab <buffer> gli2da GL_IMAGE_2D_ARRAY
  :iab <buffer> gli2d GL_IMAGE_2D
  :iab <buffer> gli2dma GL_IMAGE_2D_MULTISAMPLE_ARRAY
  :iab <buffer> gli2dm GL_IMAGE_2D_MULTISAMPLE
  :iab <buffer> gli2dr GL_IMAGE_2D_RECT
  :iab <buffer> gli3d GL_IMAGE_3D
  :iab <buffer> gliabb GL_INDEX_ARRAY_BUFFER_BINDING
  " :iab <buffer> glia GL_INDEX_ARRAY
  :iab <buffer> glia GL_INTERLEAVED_ATTRIBS
  :iab <buffer> gliap GL_INDEX_ARRAY_POINTER
  " :iab <buffer> glias GL_INDEX_ARRAY_STRIDE
  :iab <buffer> glias GL_INTERNALFORMAT_ALPHA_SIZE
  " :iab <buffer> gliat GL_INDEX_ARRAY_TYPE
  :iab <buffer> gliat GL_INTERNALFORMAT_ALPHA_TYPE
  :iab <buffer> gliba GL_IMAGE_BINDING_ACCESS
  :iab <buffer> glibf GL_IMAGE_BINDING_FORMAT
  " :iab <buffer> glib GL_IMAGE_BUFFER
  :iab <buffer> glib GL_INDEX_BITS
  " :iab <buffer> glibl GL_IMAGE_BINDING_LAYER
  " :iab <buffer> glibl GL_IMAGE_BINDING_LAYERED
  :iab <buffer> glibl GL_IMAGE_BINDING_LEVEL
  :iab <buffer> glibn GL_IMAGE_BINDING_NAME
  :iab <buffer> glibs GL_INTERNALFORMAT_BLUE_SIZE
  :iab <buffer> glibt GL_INTERNALFORMAT_BLUE_TYPE
  :iab <buffer> glic1010102 GL_IMAGE_CLASS_10_10_10_2
  :iab <buffer> glic111110 GL_IMAGE_CLASS_11_11_10
  :iab <buffer> glic1x16 GL_IMAGE_CLASS_1_X_16
  :iab <buffer> glic1x32 GL_IMAGE_CLASS_1_X_32
  :iab <buffer> glic1x8 GL_IMAGE_CLASS_1_X_8
  :iab <buffer> glic2x16 GL_IMAGE_CLASS_2_X_16
  :iab <buffer> glic2x32 GL_IMAGE_CLASS_2_X_32
  :iab <buffer> glic2x8 GL_IMAGE_CLASS_2_X_8
  :iab <buffer> glic4x16 GL_IMAGE_CLASS_4_X_16
  :iab <buffer> glic4x32 GL_IMAGE_CLASS_4_X_32
  :iab <buffer> glic4x8 GL_IMAGE_CLASS_4_X_8
  :iab <buffer> glicc GL_IMAGE_COMPATIBILITY_CLASS
  :iab <buffer> glic GL_IMAGE_CUBE
  :iab <buffer> glicma GL_IMAGE_CUBE_MAP_ARRAY
  :iab <buffer> glicrf GL_IMPLEMENTATION_COLOR_READ_FORMAT
  :iab <buffer> glicr GL_INNOCENT_CONTEXT_RESET
  :iab <buffer> glicrt GL_IMPLEMENTATION_COLOR_READ_TYPE
  :iab <buffer> glicv GL_INDEX_CLEAR_VALUE
  :iab <buffer> glids GL_INTERNALFORMAT_DEPTH_SIZE
  :iab <buffer> glidt GL_INTERNALFORMAT_DEPTH_TYPE
  :iab <buffer> glie GL_INVALID_ENUM
  :iab <buffer> glifcbc GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS
  :iab <buffer> glifcbs GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE
  :iab <buffer> glifct GL_IMAGE_FORMAT_COMPATIBILITY_TYPE
  :iab <buffer> glifo GL_INVALID_FRAMEBUFFER_OPERATION
  :iab <buffer> gligs GL_INTERNALFORMAT_GREEN_SIZE
  :iab <buffer> gligt GL_INTERNALFORMAT_GREEN_TYPE
  :iab <buffer> glii1da GL_INT_IMAGE_1D_ARRAY
  :iab <buffer> glii1d GL_INT_IMAGE_1D
  :iab <buffer> glii2da GL_INT_IMAGE_2D_ARRAY
  :iab <buffer> glii2d GL_INT_IMAGE_2D
  :iab <buffer> glii2dma GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY
  :iab <buffer> glii2dm GL_INT_IMAGE_2D_MULTISAMPLE
  :iab <buffer> glii2dr GL_INT_IMAGE_2D_RECT
  :iab <buffer> glii3d GL_INT_IMAGE_3D
  :iab <buffer> gliib GL_INT_IMAGE_BUFFER
  :iab <buffer> gliic GL_INT_IMAGE_CUBE
  :iab <buffer> gliicma GL_INT_IMAGE_CUBE_MAP_ARRAY
  :iab <buffer> glii GL_INVALID_INDEX
  :iab <buffer> glill GL_INFO_LOG_LENGTH
  :iab <buffer> glilo GL_INDEX_LOGIC_OP
  :iab <buffer> glim GL_INDEX_MODE
  " :iab <buffer> glio GL_INDEX_OFFSET
  :iab <buffer> glio GL_INVALID_OPERATION
  :iab <buffer> glipf GL_IMAGE_PIXEL_FORMAT
  :iab <buffer> glip GL_INTERNALFORMAT_PREFERRED
  :iab <buffer> glipp GL_IS_PER_PATCH
  :iab <buffer> glipt GL_IMAGE_PIXEL_TYPE
  :iab <buffer> glirm GL_IS_ROW_MAJOR
  :iab <buffer> glirs GL_INTERNALFORMAT_RED_SIZE
  :iab <buffer> glirt GL_INTERNALFORMAT_RED_TYPE
  :iab <buffer> glis1da GL_INT_SAMPLER_1D_ARRAY
  :iab <buffer> glis1d GL_INT_SAMPLER_1D
  :iab <buffer> glis2da GL_INT_SAMPLER_2D_ARRAY
  :iab <buffer> glis2d GL_INT_SAMPLER_2D
  :iab <buffer> glis2dma GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY
  :iab <buffer> glis2dm GL_INT_SAMPLER_2D_MULTISAMPLE
  :iab <buffer> glis2dr GL_INT_SAMPLER_2D_RECT
  :iab <buffer> glis3d GL_INT_SAMPLER_3D
  :iab <buffer> glisb GL_INT_SAMPLER_BUFFER
  :iab <buffer> glisc GL_INT_SAMPLER_CUBE
  :iab <buffer> gliscma GL_INT_SAMPLER_CUBE_MAP_ARRAY
  " :iab <buffer> glis GL_INDEX_SHIFT
  :iab <buffer> glis GL_INTERNALFORMAT_SUPPORTED
  " :iab <buffer> gliss GL_INTERNALFORMAT_SHARED_SIZE
  :iab <buffer> gliss GL_INTERNALFORMAT_STENCIL_SIZE
  :iab <buffer> glist GL_INTERNALFORMAT_STENCIL_TYPE
  :iab <buffer> gliswr GL_INVERTED_SCREEN_W_REND
  :iab <buffer> glits GL_IMAGE_TEXEL_SIZE
  :iab <buffer> gliv2 GL_INT_VEC2
  :iab <buffer> gliv3 GL_INT_VEC3
  :iab <buffer> gliv4 GL_INT_VEC4
  :iab <buffer> gliv GL_INVALID_VALUE
  " :iab <buffer> gliw GL_INCR_WRAP
  :iab <buffer> gliw GL_INDEX_WRITEMASK
  :iab <buffer> gll12a12 GL_LUMINANCE12_ALPHA12
  :iab <buffer> gll12a4 GL_LUMINANCE12_ALPHA4
  :iab <buffer> gll16a16 GL_LUMINANCE16_ALPHA16
  :iab <buffer> gll4a4 GL_LUMINANCE4_ALPHA4
  :iab <buffer> gll6a2 GL_LUMINANCE6_ALPHA2
  :iab <buffer> gll8a8 GL_LUMINANCE8_ALPHA8
  " :iab <buffer> glla GL_LINEAR_ATTENUATION
  " :iab <buffer> glla GL_LINES_ADJACENCY
  :iab <buffer> glla GL_LUMINANCE_ALPHA
  " :iab <buffer> gllb GL_LIGHTING_BIT
  " :iab <buffer> gllb GL_LINE_BIT
  " :iab <buffer> gllb GL_LIST_BASE
  :iab <buffer> gllb GL_LIST_BIT
  :iab <buffer> gllc GL_LOCATION_COMPONENT
  :iab <buffer> gllcor GL_LOSE_CONTEXT_ON_RESET
  :iab <buffer> gllf GL_LOW_FLOAT
  " :iab <buffer> glli GL_LIST_INDEX
  " :iab <buffer> glli GL_LOCATION_INDEX
  :iab <buffer> glli GL_LOW_INT
  " :iab <buffer> glll GL_LINE_LOOP
  :iab <buffer> glll GL_LOWER_LEFT
  :iab <buffer> gllma GL_LIGHT_MODEL_AMBIENT
  :iab <buffer> gllmcc GL_LIGHT_MODEL_COLOR_CONTROL
  :iab <buffer> gllm GL_LIST_MODE
  :iab <buffer> gllml GL_LINEAR_MIPMAP_LINEAR
  :iab <buffer> gllmlv GL_LIGHT_MODEL_LOCAL_VIEWER
  :iab <buffer> gllmn GL_LINEAR_MIPMAP_NEAREST
  :iab <buffer> gllmts GL_LIGHT_MODEL_TWO_SIDE
  :iab <buffer> gllo GL_LOGIC_OP
  :iab <buffer> gllom GL_LOGIC_OP_MODE
  :iab <buffer> gllpv GL_LAYER_PROVOKING_VERTEX
  :iab <buffer> gllrt GL_LINE_RESET_TOKEN
  :iab <buffer> gllsa GL_LINE_STRIP_ADJACENCY
  " :iab <buffer> glls GL_LINE_SMOOTH
  " :iab <buffer> glls GL_LINE_STIPPLE
  " :iab <buffer> glls GL_LINE_STRIP
  :iab <buffer> glls GL_LINK_STATUS
  :iab <buffer> gllsh GL_LINE_SMOOTH_HINT
  :iab <buffer> gllsp GL_LINE_STIPPLE_PATTERN
  :iab <buffer> gllsr GL_LINE_STIPPLE_REPEAT
  :iab <buffer> gllt GL_LINE_TOKEN
  :iab <buffer> gllvc GL_LAST_VERTEX_CONVENTION
  :iab <buffer> gllwg GL_LINE_WIDTH_GRANULARITY
  :iab <buffer> gllw GL_LINE_WIDTH
  :iab <buffer> gllwr GL_LINE_WIDTH_RANGE
  :iab <buffer> glm1c4 GL_MAP1_COLOR_4
  :iab <buffer> glm1gd GL_MAP1_GRID_DOMAIN
  :iab <buffer> glm1gs GL_MAP1_GRID_SEGMENTS
  :iab <buffer> glm1i GL_MAP1_INDEX
  :iab <buffer> glm1n GL_MAP1_NORMAL
  :iab <buffer> glm1tc1 GL_MAP1_TEXTURE_COORD_1
  :iab <buffer> glm1tc2 GL_MAP1_TEXTURE_COORD_2
  :iab <buffer> glm1tc3 GL_MAP1_TEXTURE_COORD_3
  :iab <buffer> glm1tc4 GL_MAP1_TEXTURE_COORD_4
  :iab <buffer> glm1v3 GL_MAP1_VERTEX_3
  :iab <buffer> glm1v4 GL_MAP1_VERTEX_4
  :iab <buffer> glm2c4 GL_MAP2_COLOR_4
  :iab <buffer> glm2gd GL_MAP2_GRID_DOMAIN
  :iab <buffer> glm2gs GL_MAP2_GRID_SEGMENTS
  :iab <buffer> glm2i GL_MAP2_INDEX
  :iab <buffer> glm2n GL_MAP2_NORMAL
  :iab <buffer> glm2tc1 GL_MAP2_TEXTURE_COORD_1
  :iab <buffer> glm2tc2 GL_MAP2_TEXTURE_COORD_2
  :iab <buffer> glm2tc3 GL_MAP2_TEXTURE_COORD_3
  :iab <buffer> glm2tc4 GL_MAP2_TEXTURE_COORD_4
  :iab <buffer> glm2v3 GL_MAP2_VERTEX_3
  :iab <buffer> glm2v4 GL_MAP2_VERTEX_4
  :iab <buffer> glm3dts GL_MAX_3D_TEXTURE_SIZE
  :iab <buffer> glmacbb GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS
  :iab <buffer> glmacbs GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE
  :iab <buffer> glmasd GL_MAX_ATTRIB_STACK_DEPTH
  :iab <buffer> glmatl GL_MAX_ARRAY_TEXTURE_LAYERS
  :iab <buffer> glmb GL_MULTISAMPLE_BIT
  " :iab <buffer> glmcacb GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmcacb GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS
  " :iab <buffer> glmcac GL_MAX_COMBINED_ATOMIC_COUNTERS
  :iab <buffer> glmcac GL_MAX_COMPUTE_ATOMIC_COUNTERS
  :iab <buffer> glmca GL_MAX_COLOR_ATTACHMENTS
  :iab <buffer> glmcasd GL_MAX_CLIENT_ATTRIB_STACK_DEPTH
  :iab <buffer> glmcb GL_MAP_COHERENT_BIT
  :iab <buffer> glmccacd GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES
  :iab <buffer> glmccuc GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS
  " :iab <buffer> glmcd GL_MAX_CLIP_DISTANCES
  " :iab <buffer> glmcd GL_MAX_COMBINED_DIMENSIONS
  :iab <buffer> glmcd GL_MAX_CULL_DISTANCES
  :iab <buffer> glmcfuc GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS
  :iab <buffer> glmc GL_MAP_COLOR
  :iab <buffer> glmcguc GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS
  :iab <buffer> glmch GL_MAX_CONVOLUTION_HEIGHT
  :iab <buffer> glmciuafo GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS
  " :iab <buffer> glmciu GL_MAX_COMBINED_IMAGE_UNIFORMS
  :iab <buffer> glmciu GL_MAX_COMPUTE_IMAGE_UNIFORMS
  :iab <buffer> glmcmsd GL_MAX_COLOR_MATRIX_STACK_DEPTH
  :iab <buffer> glmcmts GL_MAX_CUBE_MAP_TEXTURE_SIZE
  :iab <buffer> glmcp GL_MAX_CLIP_PLANES
  :iab <buffer> glmcsms GL_MAX_COMPUTE_SHARED_MEMORY_SIZE
  :iab <buffer> glmcsor GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES
  " :iab <buffer> glmcssb GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmcssb GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmctcuc GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS
  :iab <buffer> glmcte GL_MIRROR_CLAMP_TO_EDGE
  :iab <buffer> glmcteuc GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS
  " :iab <buffer> glmctiu GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmctiu GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmcts GL_MAX_COLOR_TEXTURE_SAMPLES
  " :iab <buffer> glmcub GL_MAX_COMBINED_UNIFORM_BLOCKS
  :iab <buffer> glmcub GL_MAX_COMPUTE_UNIFORM_BLOCKS
  :iab <buffer> glmcuc GL_MAX_COMPUTE_UNIFORM_COMPONENTS
  :iab <buffer> glmcvuc GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS
  :iab <buffer> glmcwgc GL_MAX_COMPUTE_WORK_GROUP_COUNT
  :iab <buffer> glmcwgi GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS
  :iab <buffer> glmcw GL_MAX_CONVOLUTION_WIDTH
  :iab <buffer> glmcwgs GL_MAX_COMPUTE_WORK_GROUP_SIZE
  :iab <buffer> glmdb GL_MAX_DRAW_BUFFERS
  :iab <buffer> glmd GL_MAX_DEPTH
  :iab <buffer> glmdgsd GL_MAX_DEBUG_GROUP_STACK_DEPTH
  :iab <buffer> glmdlm GL_MAX_DEBUG_LOGGED_MESSAGES
  :iab <buffer> glmdml GL_MAX_DEBUG_MESSAGE_LENGTH
  :iab <buffer> glmdsdb GL_MAX_DUAL_SOURCE_DRAW_BUFFERS
  :iab <buffer> glmdts GL_MAX_DEPTH_TEXTURE_SAMPLES
  " :iab <buffer> glmei GL_MAX_ELEMENT_INDEX
  :iab <buffer> glmei GL_MAX_ELEMENTS_INDICES
  :iab <buffer> glmeo GL_MAX_EVAL_ORDER
  :iab <buffer> glmev GL_MAX_ELEMENTS_VERTICES
  :iab <buffer> glmfacb GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmfac GL_MAX_FRAGMENT_ATOMIC_COUNTERS
  :iab <buffer> glmfeb GL_MAP_FLUSH_EXPLICIT_BIT
  " :iab <buffer> glmf GL_MEDIUM_FLOAT
  :iab <buffer> glmf GL_MINMAX_FORMAT
  :iab <buffer> glmfh GL_MAX_FRAMEBUFFER_HEIGHT
  :iab <buffer> glmfic GL_MAX_FRAGMENT_INPUT_COMPONENTS
  " :iab <buffer> glmfio GL_MAX_FRAGMENT_INTERPOLATION_OFFSET
  :iab <buffer> glmfio GL_MIN_FRAGMENT_INTERPOLATION_OFFSET
  :iab <buffer> glmfiu GL_MAX_FRAGMENT_IMAGE_UNIFORMS
  :iab <buffer> glmfl GL_MAX_FRAMEBUFFER_LAYERS
  :iab <buffer> glmfs GL_MAX_FRAMEBUFFER_SAMPLES
  :iab <buffer> glmfssb GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmfub GL_MAX_FRAGMENT_UNIFORM_BLOCKS
  :iab <buffer> glmfuc GL_MAX_FRAGMENT_UNIFORM_COMPONENTS
  :iab <buffer> glmfuv GL_MAX_FRAGMENT_UNIFORM_VECTORS
  :iab <buffer> glmfw GL_MAX_FRAMEBUFFER_WIDTH
  :iab <buffer> glmgacb GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmgac GL_MAX_GEOMETRY_ATOMIC_COUNTERS
  :iab <buffer> glmgic GL_MAX_GEOMETRY_INPUT_COMPONENTS
  :iab <buffer> glmgiu GL_MAX_GEOMETRY_IMAGE_UNIFORMS
  :iab <buffer> glmgm GL_MANUAL_GENERATE_MIPMAP
  :iab <buffer> glmgoc GL_MAX_GEOMETRY_OUTPUT_COMPONENTS
  :iab <buffer> glmgov GL_MAX_GEOMETRY_OUTPUT_VERTICES
  :iab <buffer> glmgsi GL_MAX_GEOMETRY_SHADER_INVOCATIONS
  :iab <buffer> glmgssb GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmgtiu GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmgtoc GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS
  :iab <buffer> glmgub GL_MAX_GEOMETRY_UNIFORM_BLOCKS
  :iab <buffer> glmguc GL_MAX_GEOMETRY_UNIFORM_COMPONENTS
  :iab <buffer> glmh GL_MAX_HEIGHT
  :iab <buffer> glmibb GL_MAP_INVALIDATE_BUFFER_BIT
  :iab <buffer> glmi GL_MEDIUM_INT
  :iab <buffer> glmirb GL_MAP_INVALIDATE_RANGE_BIT
  " :iab <buffer> glmis GL_MAX_IMAGE_SAMPLES
  :iab <buffer> glmis GL_MAX_INTEGER_SAMPLES
  :iab <buffer> glmiu GL_MAX_IMAGE_UNITS
  " :iab <buffer> glml GL_MAX_LAYERS
  :iab <buffer> glml GL_MAX_LIGHTS
  :iab <buffer> glmll GL_MAX_LABEL_LENGTH
  :iab <buffer> glmln GL_MAX_LIST_NESTING
  :iab <buffer> glmmba GL_MIN_MAP_BUFFER_ALIGNMENT
  " :iab <buffer> glmm GL_MATRIX_MODE
  :iab <buffer> glmm GL_MODELVIEW_MATRIX
  :iab <buffer> glmmsd GL_MAX_MODELVIEW_STACK_DEPTH
  :iab <buffer> glmnav GL_MAX_NUM_ACTIVE_VARIABLES
  :iab <buffer> glmncs GL_MAX_NUM_COMPATIBLE_SUBROUTINES
  :iab <buffer> glmnl GL_MAX_NAME_LENGTH
  :iab <buffer> glmnsd GL_MAX_NAME_STACK_DEPTH
  :iab <buffer> glmpb GL_MAP_PERSISTENT_BIT
  :iab <buffer> glmpmt GL_MAX_PIXEL_MAP_TABLE
  :iab <buffer> glmpsd GL_MAX_PROJECTION_STACK_DEPTH
  " :iab <buffer> glmptgo GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET
  :iab <buffer> glmptgo GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET
  " :iab <buffer> glmpto GL_MAX_PROGRAM_TEXEL_OFFSET
  :iab <buffer> glmpto GL_MIN_PROGRAM_TEXEL_OFFSET
  :iab <buffer> glmpv GL_MAX_PATCH_VERTICES
  :iab <buffer> glmrb GL_MAP_READ_BIT
  :iab <buffer> glmr GL_MIRRORED_REPEAT
  :iab <buffer> glmrs GL_MAX_RENDERBUFFER_SIZE
  :iab <buffer> glmrts GL_MAX_RECTANGLE_TEXTURE_SIZE
  :iab <buffer> glmsatl GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS
  :iab <buffer> glmsd GL_MODELVIEW_STACK_DEPTH
  " :iab <buffer> glms GL_MAP_STENCIL
  " :iab <buffer> glms GL_MATRIX_STRIDE
  " :iab <buffer> glms GL_MAX_SAMPLES
  " :iab <buffer> glms GL_MAX_SUBROUTINES
  :iab <buffer> glms GL_MINMAX_SINK
  :iab <buffer> glmsmw GL_MAX_SAMPLE_MASK_WORDS
  :iab <buffer> glmssbb GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS
  :iab <buffer> glmssbs GL_MAX_SHADER_STORAGE_BLOCK_SIZE
  :iab <buffer> glmssv GL_MIN_SAMPLE_SHADING_VALUE
  :iab <buffer> glmsul GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS
  :iab <buffer> glmswt GL_MAX_SERVER_WAIT_TIMEOUT
  :iab <buffer> glmtbs GL_MAX_TEXTURE_BUFFER_SIZE
  :iab <buffer> glmtcacb GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmtcac GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS
  :iab <buffer> glmtc GL_MAX_TEXTURE_COORDS
  :iab <buffer> glmtcic GL_MAX_TESS_CONTROL_INPUT_COMPONENTS
  :iab <buffer> glmtciu GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS
  :iab <buffer> glmtcoc GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS
  :iab <buffer> glmtcssb GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmtctiu GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmtctoc GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS
  :iab <buffer> glmtcub GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS
  :iab <buffer> glmtcuc GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS
  :iab <buffer> glmteacb GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmteac GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS
  :iab <buffer> glmteic GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS
  :iab <buffer> glmteiu GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS
  :iab <buffer> glmteoc GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS
  :iab <buffer> glmtessb GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmtetiu GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmteub GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS
  :iab <buffer> glmteuc GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS
  :iab <buffer> glmtfb GL_MAX_TRANSFORM_FEEDBACK_BUFFERS
  :iab <buffer> glmtfic GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS
  :iab <buffer> glmtfsa GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS
  :iab <buffer> glmtfsc GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS
  :iab <buffer> glmtgl GL_MAX_TESS_GEN_LEVEL
  :iab <buffer> glmtiu GL_MAX_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmtlb GL_MAX_TEXTURE_LOD_BIAS
  :iab <buffer> glmtma GL_MAX_TEXTURE_MAX_ANISOTROPY
  :iab <buffer> glmtpc GL_MAX_TESS_PATCH_COMPONENTS
  :iab <buffer> glmtsd GL_MAX_TEXTURE_STACK_DEPTH
  :iab <buffer> glmts GL_MAX_TEXTURE_SIZE
  :iab <buffer> glmtu GL_MAX_TEXTURE_UNITS
  :iab <buffer> glmubb GL_MAX_UNIFORM_BUFFER_BINDINGS
  :iab <buffer> glmub GL_MAP_UNSYNCHRONIZED_BIT
  :iab <buffer> glmubs GL_MAX_UNIFORM_BLOCK_SIZE
  :iab <buffer> glmul GL_MAX_UNIFORM_LOCATIONS
  :iab <buffer> glmvab GL_MAX_VERTEX_ATTRIB_BINDINGS
  :iab <buffer> glmvacb GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS
  :iab <buffer> glmvac GL_MAX_VERTEX_ATOMIC_COUNTERS
  :iab <buffer> glmva GL_MAX_VERTEX_ATTRIBS
  :iab <buffer> glmvaro GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET
  :iab <buffer> glmvas GL_MAX_VERTEX_ATTRIB_STRIDE
  :iab <buffer> glmvc GL_MAX_VARYING_COMPONENTS
  :iab <buffer> glmvd GL_MAX_VIEWPORT_DIMS
  :iab <buffer> glmvf GL_MAX_VARYING_FLOATS
  " :iab <buffer> glmv GL_MAJOR_VERSION
  " :iab <buffer> glmv GL_MAX_VIEWPORTS
  :iab <buffer> glmv GL_MINOR_VERSION
  :iab <buffer> glmviu GL_MAX_VERTEX_IMAGE_UNIFORMS
  :iab <buffer> glmvoc GL_MAX_VERTEX_OUTPUT_COMPONENTS
  :iab <buffer> glmvs GL_MAX_VERTEX_STREAMS
  :iab <buffer> glmvssb GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS
  :iab <buffer> glmvtiu GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS
  :iab <buffer> glmvub GL_MAX_VERTEX_UNIFORM_BLOCKS
  :iab <buffer> glmvuc GL_MAX_VERTEX_UNIFORM_COMPONENTS
  :iab <buffer> glmvuv GL_MAX_VERTEX_UNIFORM_VECTORS
  :iab <buffer> glmvv GL_MAX_VARYING_VECTORS
  :iab <buffer> glmwb GL_MAP_WRITE_BIT
  :iab <buffer> glmw GL_MAX_WIDTH
  :iab <buffer> gln3fv3f GL_N3F_V3F
  :iab <buffer> glnabb GL_NORMAL_ARRAY_BUFFER_BINDING
  :iab <buffer> glna GL_NORMAL_ARRAY
  :iab <buffer> glnap GL_NORMAL_ARRAY_POINTER
  :iab <buffer> glnas GL_NORMAL_ARRAY_STRIDE
  :iab <buffer> glnat GL_NORMAL_ARRAY_TYPE
  :iab <buffer> glnav GL_NUM_ACTIVE_VARIABLES
  :iab <buffer> glncs GL_NUM_COMPATIBLE_SUBROUTINES
  :iab <buffer> glnctf GL_NUM_COMPRESSED_TEXTURE_FORMATS
  :iab <buffer> glnl GL_NAME_LENGTH
  :iab <buffer> glnm GL_NORMAL_MAP
  :iab <buffer> glnml GL_NEAREST_MIPMAP_LINEAR
  :iab <buffer> glnmn GL_NEAREST_MIPMAP_NEAREST
  :iab <buffer> glnoto GL_NEGATIVE_ONE_TO_ONE
  :iab <buffer> glnpbf GL_NUM_PROGRAM_BINARY_FORMATS
  :iab <buffer> glnrn GL_NO_RESET_NOTIFICATION
  :iab <buffer> glnsbf GL_NUM_SHADER_BINARY_FORMATS
  :iab <buffer> glnsc GL_NUM_SAMPLE_COUNTS
  :iab <buffer> glnsd GL_NAME_STACK_DEPTH
  :iab <buffer> glnslv GL_NUM_SHADING_LANGUAGE_VERSIONS
  :iab <buffer> glo0a GL_OPERAND0_ALPHA
  :iab <buffer> glo0r GL_OPERAND0_RGB
  :iab <buffer> glo1a GL_OPERAND1_ALPHA
  :iab <buffer> glo1r GL_OPERAND1_RGB
  :iab <buffer> glo2a GL_OPERAND2_ALPHA
  :iab <buffer> glo2r GL_OPERAND2_RGB
  :iab <buffer> gloi GL_OR_INVERTED
  :iab <buffer> glol GL_OBJECT_LINEAR
  :iab <buffer> glomca GL_ONE_MINUS_CONSTANT_ALPHA
  :iab <buffer> glomcc GL_ONE_MINUS_CONSTANT_COLOR
  :iab <buffer> glomda GL_ONE_MINUS_DST_ALPHA
  :iab <buffer> glomdc GL_ONE_MINUS_DST_COLOR
  :iab <buffer> gloms1a GL_ONE_MINUS_SRC1_ALPHA
  :iab <buffer> gloms1c GL_ONE_MINUS_SRC1_COLOR
  :iab <buffer> glomsa GL_ONE_MINUS_SRC_ALPHA
  :iab <buffer> glomsc GL_ONE_MINUS_SRC_COLOR
  :iab <buffer> gloom GL_OUT_OF_MEMORY
  :iab <buffer> glop GL_OBJECT_PLANE
  :iab <buffer> glor GL_OR_REVERSE
  :iab <buffer> glot GL_OBJECT_TYPE
  :iab <buffer> glpa GL_PACK_ALIGNMENT
  :iab <buffer> glpbbb GL_PIXEL_BUFFER_BARRIER_BIT
  :iab <buffer> glpbb GL_PARAMETER_BUFFER_BINDING
  :iab <buffer> glpbf GL_PROGRAM_BINARY_FORMATS
  " :iab <buffer> glpb GL_PARAMETER_BUFFER
  " :iab <buffer> glpb GL_POINT_BIT
  :iab <buffer> glpb GL_POLYGON_BIT
  :iab <buffer> glpbl GL_PROGRAM_BINARY_LENGTH
  :iab <buffer> glpbrh GL_PROGRAM_BINARY_RETRIEVABLE_HINT
  :iab <buffer> glpcab GL_POST_CONVOLUTION_ALPHA_BIAS
  :iab <buffer> glpcas GL_POST_CONVOLUTION_ALPHA_SCALE
  :iab <buffer> glpcbb GL_POST_CONVOLUTION_BLUE_BIAS
  :iab <buffer> glpcbd GL_PACK_COMPRESSED_BLOCK_DEPTH
  :iab <buffer> glpcbh GL_PACK_COMPRESSED_BLOCK_HEIGHT
  " :iab <buffer> glpcbs GL_PACK_COMPRESSED_BLOCK_SIZE
  :iab <buffer> glpcbs GL_POST_CONVOLUTION_BLUE_SCALE
  :iab <buffer> glpcbw GL_PACK_COMPRESSED_BLOCK_WIDTH
  :iab <buffer> glpcct GL_POST_CONVOLUTION_COLOR_TABLE
  :iab <buffer> glpcgb GL_POST_CONVOLUTION_GREEN_BIAS
  :iab <buffer> glpc GL_PRIMARY_COLOR
  :iab <buffer> glpcgs GL_POST_CONVOLUTION_GREEN_SCALE
  :iab <buffer> glpch GL_PERSPECTIVE_CORRECTION_HINT
  :iab <buffer> glpcmab GL_POST_COLOR_MATRIX_ALPHA_BIAS
  :iab <buffer> glpcmas GL_POST_COLOR_MATRIX_ALPHA_SCALE
  :iab <buffer> glpcmbb GL_POST_COLOR_MATRIX_BLUE_BIAS
  :iab <buffer> glpcmbs GL_POST_COLOR_MATRIX_BLUE_SCALE
  :iab <buffer> glpcmct GL_POST_COLOR_MATRIX_COLOR_TABLE
  :iab <buffer> glpcmgb GL_POST_COLOR_MATRIX_GREEN_BIAS
  :iab <buffer> glpcmgs GL_POST_COLOR_MATRIX_GREEN_SCALE
  :iab <buffer> glpcmrb GL_POST_COLOR_MATRIX_RED_BIAS
  :iab <buffer> glpcmrs GL_POST_COLOR_MATRIX_RED_SCALE
  :iab <buffer> glpcrb GL_POST_CONVOLUTION_RED_BIAS
  :iab <buffer> glpcrs GL_POST_CONVOLUTION_RED_SCALE
  :iab <buffer> glpct GL_PROXY_COLOR_TABLE
  :iab <buffer> glpda GL_POINT_DISTANCE_ATTENUATION
  :iab <buffer> glpdil GL_PATCH_DEFAULT_INNER_LEVEL
  :iab <buffer> glpdol GL_PATCH_DEFAULT_OUTER_LEVEL
  :iab <buffer> glpfts GL_POINT_FADE_THRESHOLD_SIZE
  :iab <buffer> glpg GL_PRIMITIVES_GENERATED
  :iab <buffer> glph GL_PROXY_HISTOGRAM
  :iab <buffer> glpi GL_PROGRAM_INPUT
  :iab <buffer> glpih GL_PACK_IMAGE_HEIGHT
  :iab <buffer> glplf GL_PACK_LSB_FIRST
  :iab <buffer> glpmata GL_PIXEL_MAP_A_TO_A
  :iab <buffer> glpmatas GL_PIXEL_MAP_A_TO_A_SIZE
  :iab <buffer> glpmb GL_PIXEL_MODE_BIT
  :iab <buffer> glpmbtb GL_PIXEL_MAP_B_TO_B
  :iab <buffer> glpmbtbs GL_PIXEL_MAP_B_TO_B_SIZE
  " :iab <buffer> glpm GL_POLYGON_MODE
  :iab <buffer> glpm GL_PROJECTION_MATRIX
  :iab <buffer> glpmgtg GL_PIXEL_MAP_G_TO_G
  :iab <buffer> glpmgtgs GL_PIXEL_MAP_G_TO_G_SIZE
  :iab <buffer> glpmita GL_PIXEL_MAP_I_TO_A
  :iab <buffer> glpmitas GL_PIXEL_MAP_I_TO_A_SIZE
  :iab <buffer> glpmitb GL_PIXEL_MAP_I_TO_B
  :iab <buffer> glpmitbs GL_PIXEL_MAP_I_TO_B_SIZE
  :iab <buffer> glpmitg GL_PIXEL_MAP_I_TO_G
  :iab <buffer> glpmitgs GL_PIXEL_MAP_I_TO_G_SIZE
  :iab <buffer> glpmiti GL_PIXEL_MAP_I_TO_I
  :iab <buffer> glpmitis GL_PIXEL_MAP_I_TO_I_SIZE
  :iab <buffer> glpmitr GL_PIXEL_MAP_I_TO_R
  :iab <buffer> glpmitrs GL_PIXEL_MAP_I_TO_R_SIZE
  :iab <buffer> glpmrtr GL_PIXEL_MAP_R_TO_R
  :iab <buffer> glpmrtrs GL_PIXEL_MAP_R_TO_R_SIZE
  :iab <buffer> glpmsts GL_PIXEL_MAP_S_TO_S
  :iab <buffer> glpmstss GL_PIXEL_MAP_S_TO_S_SIZE
  :iab <buffer> glpoc GL_POLYGON_OFFSET_CLAMP
  " :iab <buffer> glpof GL_POLYGON_OFFSET_FACTOR
  :iab <buffer> glpof GL_POLYGON_OFFSET_FILL
  :iab <buffer> glpo GL_PROGRAM_OUTPUT
  :iab <buffer> glpol GL_POLYGON_OFFSET_LINE
  :iab <buffer> glpop GL_POLYGON_OFFSET_POINT
  :iab <buffer> glpou GL_POLYGON_OFFSET_UNITS
  :iab <buffer> glppbb GL_PIXEL_PACK_BUFFER_BINDING
  " :iab <buffer> glppb GL_PIXEL_PACK_BUFFER
  :iab <buffer> glppb GL_PROGRAM_PIPELINE_BINDING
  :iab <buffer> glppcct GL_PROXY_POST_CONVOLUTION_COLOR_TABLE
  :iab <buffer> glppcmct GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE
  :iab <buffer> glpp GL_PROGRAM_PIPELINE
  :iab <buffer> glpps GL_PROGRAM_POINT_SIZE
  :iab <buffer> glprfi GL_PRIMITIVE_RESTART_FIXED_INDEX
  :iab <buffer> glprfps GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED
  :iab <buffer> glpr GL_PRIMITIVE_RESTART
  :iab <buffer> glpri GL_PRIMITIVE_RESTART_INDEX
  :iab <buffer> glprl GL_PACK_ROW_LENGTH
  " :iab <buffer> glpsb GL_PACK_SWAP_BYTES
  :iab <buffer> glpsb GL_POLYGON_STIPPLE_BIT
  :iab <buffer> glpsco GL_POINT_SPRITE_COORD_ORIGIN
  :iab <buffer> glpsd GL_PROJECTION_STACK_DEPTH
  :iab <buffer> glpsg GL_POINT_SIZE_GRANULARITY
  :iab <buffer> glps GL_POINT_SIZE
  " :iab <buffer> glps GL_POINT_SMOOTH
  " :iab <buffer> glps GL_POINT_SPRITE
  " :iab <buffer> glps GL_POLYGON_SMOOTH
  " :iab <buffer> glps GL_POLYGON_STIPPLE
  " :iab <buffer> glps GL_PRIMITIVES_SUBMITTED
  ":iab <buffer> glps GL_PROGRAM_SEPARABLE
  " :iab <buffer> glpsh GL_POINT_SMOOTH_HINT
  :iab <buffer> glpsh GL_POLYGON_SMOOTH_HINT
  :iab <buffer> glpsi GL_PACK_SKIP_IMAGES
  " :iab <buffer> glpsm GL_POINT_SIZE_MAX
  :iab <buffer> glpsm GL_POINT_SIZE_MIN
  :iab <buffer> glpsp GL_PACK_SKIP_PIXELS
  " :iab <buffer> glpsr GL_PACK_SKIP_ROWS
  :iab <buffer> glpsr GL_POINT_SIZE_RANGE
  :iab <buffer> glpt1da GL_PROXY_TEXTURE_1D_ARRAY
  :iab <buffer> glpt1d GL_PROXY_TEXTURE_1D
  :iab <buffer> glpt2da GL_PROXY_TEXTURE_2D_ARRAY
  :iab <buffer> glpt2d GL_PROXY_TEXTURE_2D
  :iab <buffer> glpt2dma GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY
  :iab <buffer> glpt2dm GL_PROXY_TEXTURE_2D_MULTISAMPLE
  :iab <buffer> glpt3d GL_PROXY_TEXTURE_3D
  :iab <buffer> glptcma GL_PROXY_TEXTURE_CUBE_MAP_ARRAY
  :iab <buffer> glptcm GL_PROXY_TEXTURE_CUBE_MAP
  " :iab <buffer> glpt GL_POINT_TOKEN
  :iab <buffer> glpt GL_POLYGON_TOKEN
  :iab <buffer> glptr GL_PROXY_TEXTURE_RECTANGLE
  :iab <buffer> glptt GL_PASS_THROUGH_TOKEN
  :iab <buffer> glpubb GL_PIXEL_UNPACK_BUFFER_BINDING
  :iab <buffer> glpub GL_PIXEL_UNPACK_BUFFER
  " :iab <buffer> glpv GL_PATCH_VERTICES
  :iab <buffer> glpv GL_PROVOKING_VERTEX
  :iab <buffer> glqa GL_QUADRATIC_ATTENUATION
  :iab <buffer> glqbbb GL_QUERY_BUFFER_BARRIER_BIT
  :iab <buffer> glqbb GL_QUERY_BUFFER_BINDING
  :iab <buffer> glqb GL_QUERY_BUFFER
  :iab <buffer> glqbrnw GL_QUERY_BY_REGION_NO_WAIT
  :iab <buffer> glqbrnwi GL_QUERY_BY_REGION_NO_WAIT_INVERTED
  :iab <buffer> glqbrw GL_QUERY_BY_REGION_WAIT
  :iab <buffer> glqbrwi GL_QUERY_BY_REGION_WAIT_INVERTED
  :iab <buffer> glqcb GL_QUERY_COUNTER_BITS
  :iab <buffer> glqfpvc GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION
  :iab <buffer> glqnw GL_QUERY_NO_WAIT
  :iab <buffer> glqnwi GL_QUERY_NO_WAIT_INVERTED
  :iab <buffer> glqra GL_QUERY_RESULT_AVAILABLE
  :iab <buffer> glqr GL_QUERY_RESULT
  :iab <buffer> glqrnw GL_QUERY_RESULT_NO_WAIT
  :iab <buffer> glqs GL_QUAD_STRIP
  :iab <buffer> glqt GL_QUERY_TARGET
  :iab <buffer> glqw GL_QUERY_WAIT
  :iab <buffer> glqwi GL_QUERY_WAIT_INVERTED
  :iab <buffer> glr10a2 GL_RGB10_A2
  :iab <buffer> glr10a2ui GL_RGB10_A2UI
  :iab <buffer> glr11fg11fb10f GL_R11F_G11F_B10F
  :iab <buffer> glr3g3b2 GL_R3_G3_B2
  :iab <buffer> glr5a1 GL_RGB5_A1
  :iab <buffer> glr9e5 GL_RGB9_E5
  :iab <buffer> glras GL_RENDERBUFFER_ALPHA_SIZE
  :iab <buffer> glrbcs GL_REFERENCED_BY_COMPUTE_SHADER
  :iab <buffer> glrbfs GL_REFERENCED_BY_FRAGMENT_SHADER
  " :iab <buffer> glrb GL_READ_BUFFER
  " :iab <buffer> glrb GL_RED_BIAS
  " :iab <buffer> glrb GL_RED_BITS
  " :iab <buffer> glrb GL_RENDERBUFFER_BINDING
  :iab <buffer> glrb GL_REPLICATE_BORDER
  :iab <buffer> glrbgs GL_REFERENCED_BY_GEOMETRY_SHADER
  :iab <buffer> glrbs GL_RENDERBUFFER_BLUE_SIZE
  :iab <buffer> glrbtcs GL_REFERENCED_BY_TESS_CONTROL_SHADER
  :iab <buffer> glrbtes GL_REFERENCED_BY_TESS_EVALUATION_SHADER
  :iab <buffer> glrbvs GL_REFERENCED_BY_VERTEX_SHADER
  :iab <buffer> glrd GL_RASTERIZER_DISCARD
  :iab <buffer> glrds GL_RENDERBUFFER_DEPTH_SIZE
  :iab <buffer> glrfb GL_READ_FRAMEBUFFER_BINDING
  :iab <buffer> glrf GL_READ_FRAMEBUFFER
  :iab <buffer> glrgs GL_RENDERBUFFER_GREEN_SIZE
  :iab <buffer> glrh GL_RENDERBUFFER_HEIGHT
  :iab <buffer> glrif GL_RENDERBUFFER_INTERNAL_FORMAT
  " :iab <buffer> glri GL_RED_INTEGER
  " :iab <buffer> glri GL_RGBA_INTEGER
  " :iab <buffer> glri GL_RGB_INTEGER
  :iab <buffer> glri GL_RG_INTEGER
  " :iab <buffer> glrm GL_REFLECTION_MAP
  " :iab <buffer> glrm GL_RENDER_MODE
  :iab <buffer> glrm GL_RGBA_MODE
  :iab <buffer> glrn GL_RESCALE_NORMAL
  :iab <buffer> glrns GL_RESET_NOTIFICATION_STRATEGY
  :iab <buffer> glro GL_READ_ONLY
  :iab <buffer> glrpf GL_READ_PIXELS_FORMAT
  :iab <buffer> glrp GL_READ_PIXELS
  :iab <buffer> glrpt GL_READ_PIXELS_TYPE
  :iab <buffer> glrrs GL_RENDERBUFFER_RED_SIZE
  " :iab <buffer> glrs GL_RED_SCALE
  " :iab <buffer> glrs GL_RENDERBUFFER_SAMPLES
  :iab <buffer> glrs GL_RGB_SCALE
  :iab <buffer> glrss GL_RENDERBUFFER_STENCIL_SIZE
  " :iab <buffer> glrw GL_READ_WRITE
  :iab <buffer> glrw GL_RENDERBUFFER_WIDTH
  " :iab <buffer> gls0a GL_SOURCE0_ALPHA
  :iab <buffer> gls0a GL_SRC0_ALPHA
  " :iab <buffer> gls0r GL_SOURCE0_RGB
  :iab <buffer> gls0r GL_SRC0_RGB
  " :iab <buffer> gls1a GL_SOURCE1_ALPHA
  :iab <buffer> gls1a GL_SRC1_ALPHA
  :iab <buffer> gls1c GL_SRC1_COLOR
  :iab <buffer> gls1da GL_SAMPLER_1D_ARRAY
  :iab <buffer> gls1das GL_SAMPLER_1D_ARRAY_SHADOW
  :iab <buffer> gls1d GL_SAMPLER_1D
  :iab <buffer> gls1ds GL_SAMPLER_1D_SHADOW
  " :iab <buffer> gls1r GL_SOURCE1_RGB
  :iab <buffer> gls1r GL_SRC1_RGB
  " :iab <buffer> gls2a GL_SOURCE2_ALPHA
  :iab <buffer> gls2a GL_SRC2_ALPHA
  :iab <buffer> gls2da GL_SAMPLER_2D_ARRAY
  :iab <buffer> gls2das GL_SAMPLER_2D_ARRAY_SHADOW
  " :iab <buffer> gls2d GL_SAMPLER_2D
  :iab <buffer> gls2d GL_SEPARABLE_2D
  :iab <buffer> gls2dma GL_SAMPLER_2D_MULTISAMPLE_ARRAY
  :iab <buffer> gls2dm GL_SAMPLER_2D_MULTISAMPLE
  :iab <buffer> gls2dr GL_SAMPLER_2D_RECT
  :iab <buffer> gls2drs GL_SAMPLER_2D_RECT_SHADOW
  :iab <buffer> gls2ds GL_SAMPLER_2D_SHADOW
  " :iab <buffer> gls2r GL_SOURCE2_RGB
  :iab <buffer> gls2r GL_SRC2_RGB
  :iab <buffer> gls3d GL_SAMPLER_3D
  " :iab <buffer> gls8a8 GL_SLUMINANCE8_ALPHA8
  :iab <buffer> gls8a8 GL_SRGB8_ALPHA8
  " :iab <buffer> glsa GL_SEPARATE_ATTRIBS
  " :iab <buffer> glsa GL_SLUMINANCE_ALPHA
  " :iab <buffer> glsa GL_SRC_ALPHA
  " :iab <buffer> glsa GL_SRGB_ALPHA
  :iab <buffer> glsa GL_STENCIL_ATTACHMENT
  :iab <buffer> glsas GL_SRC_ALPHA_SATURATE
  :iab <buffer> glsatc GL_SAMPLE_ALPHA_TO_COVERAGE
  :iab <buffer> glsato GL_SAMPLE_ALPHA_TO_ONE
  :iab <buffer> glsbb GL_STENCIL_BUFFER_BIT
  " :iab <buffer> glsbf GL_SHADER_BINARY_FORMATS
  " :iab <buffer> glsbf GL_STENCIL_BACK_FAIL
  :iab <buffer> glsbf GL_STENCIL_BACK_FUNC
  :iab <buffer> glsbfsv GL_SHADER_BINARY_FORMAT_SPIR_V
  " :iab <buffer> glsb GL_SAMPLE_BUFFERS
  " :iab <buffer> glsb GL_SAMPLER_BINDING
  " :iab <buffer> glsb GL_SAMPLER_BUFFER
  " :iab <buffer> glsb GL_SCISSOR_BIT
  " :iab <buffer> glsb GL_SCISSOR_BOX
  " :iab <buffer> glsb GL_STENCIL_BITS
  :iab <buffer> glsb GL_SUBPIXEL_BITS
  :iab <buffer> glsbpdf GL_STENCIL_BACK_PASS_DEPTH_FAIL
  :iab <buffer> glsbpdp GL_STENCIL_BACK_PASS_DEPTH_PASS
  :iab <buffer> glsbp GL_SELECTION_BUFFER_POINTER
  :iab <buffer> glsbr GL_STENCIL_BACK_REF
  :iab <buffer> glsbs GL_SELECTION_BUFFER_SIZE
  :iab <buffer> glsbvm GL_STENCIL_BACK_VALUE_MASK
  :iab <buffer> glsbw GL_STENCIL_BACK_WRITEMASK
  :iab <buffer> glscabb GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING
  :iab <buffer> glsca GL_SECONDARY_COLOR_ARRAY
  :iab <buffer> glscap GL_SECONDARY_COLOR_ARRAY_POINTER
  " :iab <buffer> glscas GL_SECONDARY_COLOR_ARRAY_SIZE
  :iab <buffer> glscas GL_SECONDARY_COLOR_ARRAY_STRIDE
  :iab <buffer> glscat GL_SECONDARY_COLOR_ARRAY_TYPE
  " :iab <buffer> glsc GL_SAMPLE_COVERAGE
  " :iab <buffer> glsc GL_SAMPLER_CUBE
  " :iab <buffer> glsc GL_SHADER_COMPILER
  " :iab <buffer> glsc GL_SINGLE_COLOR
  " :iab <buffer> glsc GL_SPOT_CUTOFF
  " :iab <buffer> glsc GL_SRC_COLOR
  " :iab <buffer> glsc GL_STATIC_COPY
  " :iab <buffer> glsc GL_STENCIL_COMPONENTS
  " :iab <buffer> glsc GL_STREAM_COPY
  :iab <buffer> glsc GL_SYNC_CONDITION
  :iab <buffer> glsci GL_SAMPLE_COVERAGE_INVERT
  :iab <buffer> glscma GL_SAMPLER_CUBE_MAP_ARRAY
  :iab <buffer> glscmas GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW
  :iab <buffer> glscr GL_SCREEN_COORDINATES_REND
  :iab <buffer> glscs GL_SAMPLER_CUBE_SHADOW
  " :iab <buffer> glscv GL_SAMPLE_COVERAGE_VALUE
  :iab <buffer> glscv GL_STENCIL_CLEAR_VALUE
  " :iab <buffer> glsd GL_SPOT_DIRECTION
  " :iab <buffer> glsd GL_STATIC_DRAW
  :iab <buffer> glsd GL_STREAM_DRAW
  :iab <buffer> glse GL_SPOT_EXPONENT
  :iab <buffer> glsfcb GL_SYNC_FLUSH_COMMANDS_BIT
  " :iab <buffer> glsf GL_STENCIL_FAIL
  " :iab <buffer> glsf GL_STENCIL_FUNC
  " :iab <buffer> glsf GL_SYNC_FENCE
  :iab <buffer> glsf GL_SYNC_FLAGS
  :iab <buffer> glsgcc GL_SYNC_GPU_COMMANDS_COMPLETE
  :iab <buffer> glsi16 GL_STENCIL_INDEX16
  :iab <buffer> glsi1 GL_STENCIL_INDEX1
  :iab <buffer> glsi4 GL_STENCIL_INDEX4
  :iab <buffer> glsi8 GL_STENCIL_INDEX8
  :iab <buffer> glsiabb GL_SHADER_IMAGE_ACCESS_BARRIER_BIT
  :iab <buffer> glsia GL_SHADER_IMAGE_ATOMIC
  :iab <buffer> glsi GL_STENCIL_INDEX
  :iab <buffer> glsil GL_SHADER_IMAGE_LOAD
  :iab <buffer> glsis GL_SHADER_IMAGE_STORE
  :iab <buffer> glslv GL_SHADING_LANGUAGE_VERSION
  :iab <buffer> glslwg GL_SMOOTH_LINE_WIDTH_GRANULARITY
  :iab <buffer> glslwr GL_SMOOTH_LINE_WIDTH_RANGE
  " :iab <buffer> glsm GL_SAMPLE_MASK
  " :iab <buffer> glsm GL_SHADE_MODEL
  :iab <buffer> glsm GL_SPHERE_MAP
  :iab <buffer> glsmv GL_SAMPLE_MASK_VALUE
  :iab <buffer> glsn GL_SIGNED_NORMALIZED
  :iab <buffer> glso GL_STACK_OVERFLOW
  :iab <buffer> glspdf GL_STENCIL_PASS_DEPTH_FAIL
  :iab <buffer> glspdp GL_STENCIL_PASS_DEPTH_PASS
  " :iab <buffer> glsp GL_SAMPLE_POSITION
  :iab <buffer> glsp GL_SAMPLES_PASSED
  :iab <buffer> glspsg GL_SMOOTH_POINT_SIZE_GRANULARITY
  :iab <buffer> glspsr GL_SMOOTH_POINT_SIZE_RANGE
  " :iab <buffer> glsr GL_SRGB_READ
  " :iab <buffer> glsr GL_STATIC_READ
  " :iab <buffer> glsr GL_STENCIL_REF
  " :iab <buffer> glsr GL_STENCIL_RENDERABLE
  :iab <buffer> glsr GL_STREAM_READ
  " :iab <buffer> glssbb GL_SHADER_STORAGE_BARRIER_BIT
  :iab <buffer> glssbb GL_SHADER_STORAGE_BUFFER_BINDING
  " :iab <buffer> glssb GL_SHADER_STORAGE_BLOCK
  :iab <buffer> glssb GL_SHADER_STORAGE_BUFFER
  :iab <buffer> glssboa GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT
  " :iab <buffer> glssbs GL_SHADER_STORAGE_BUFFER_SIZE
  :iab <buffer> glssbs GL_SHADER_STORAGE_BUFFER_START
  :iab <buffer> glssc GL_SEPARATE_SPECULAR_COLOR
  " :iab <buffer> glss GL_SAMPLE_SHADING
  :iab <buffer> glss GL_SYNC_STATUS
  :iab <buffer> glssl GL_SHADER_SOURCE_LENGTH
  :iab <buffer> glstadt GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST
  :iab <buffer> glstadw GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE
  :iab <buffer> glstast GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST
  :iab <buffer> glstasw GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE
  " :iab <buffer> glst GL_SCISSOR_TEST
  " :iab <buffer> glst GL_SHADER_TYPE
  :iab <buffer> glst GL_STENCIL_TEST
  :iab <buffer> glsu GL_STACK_UNDERFLOW
  :iab <buffer> glsvb GL_SPIR_V_BINARY
  :iab <buffer> glsvm GL_STENCIL_VALUE_MASK
  " :iab <buffer> glsw GL_SRGB_WRITE
  :iab <buffer> glsw GL_STENCIL_WRITEMASK
  :iab <buffer> glt1da GL_TEXTURE_1D_ARRAY
  :iab <buffer> glt1d GL_TEXTURE_1D
  :iab <buffer> glt2da GL_TEXTURE_2D_ARRAY
  :iab <buffer> glt2d GL_TEXTURE_2D
  :iab <buffer> glt2dma GL_TEXTURE_2D_MULTISAMPLE_ARRAY
  :iab <buffer> glt2dm GL_TEXTURE_2D_MULTISAMPLE
  :iab <buffer> glt2fc3fv3f GL_T2F_C3F_V3F
  :iab <buffer> glt2fc4fn3fv3f GL_T2F_C4F_N3F_V3F
  :iab <buffer> glt2fc4ubv3f GL_T2F_C4UB_V3F
  :iab <buffer> glt2fn3fv3f GL_T2F_N3F_V3F
  :iab <buffer> glt2fv3f GL_T2F_V3F
  :iab <buffer> glt3d GL_TEXTURE_3D
  :iab <buffer> glt4fc4fn3fv4f GL_T4F_C4F_N3F_V4F
  :iab <buffer> glt4fv4f GL_T4F_V4F
  :iab <buffer> glta GL_TRIANGLES_ADJACENCY
  :iab <buffer> gltas GL_TEXTURE_ALPHA_SIZE
  :iab <buffer> gltat GL_TEXTURE_ALPHA_TYPE
  :iab <buffer> gltb1da GL_TEXTURE_BINDING_1D_ARRAY
  :iab <buffer> gltb1d GL_TEXTURE_BINDING_1D
  :iab <buffer> gltb2da GL_TEXTURE_BINDING_2D_ARRAY
  :iab <buffer> gltb2d GL_TEXTURE_BINDING_2D
  :iab <buffer> gltb2dma GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY
  :iab <buffer> gltb2dm GL_TEXTURE_BINDING_2D_MULTISAMPLE
  :iab <buffer> gltb3d GL_TEXTURE_BINDING_3D
  " :iab <buffer> gltbb GL_TEXTURE_BINDING_BUFFER
  :iab <buffer> gltbb GL_TEXTURE_BUFFER_BINDING
  :iab <buffer> gltbc GL_TEXTURE_BORDER_COLOR
  :iab <buffer> gltbcma GL_TEXTURE_BINDING_CUBE_MAP_ARRAY
  :iab <buffer> gltbcm GL_TEXTURE_BINDING_CUBE_MAP
  :iab <buffer> gltbdsb GL_TEXTURE_BUFFER_DATA_STORE_BINDING
  " :iab <buffer> gltb GL_TEXTURE_BIT
  " :iab <buffer> gltb GL_TEXTURE_BORDER
  " :iab <buffer> gltb GL_TEXTURE_BUFFER
  :iab <buffer> gltb GL_TRANSFORM_BIT
  :iab <buffer> gltbl GL_TEXTURE_BASE_LEVEL
  :iab <buffer> gltboa GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT
  :iab <buffer> gltbo GL_TEXTURE_BUFFER_OFFSET
  :iab <buffer> gltbr GL_TEXTURE_BINDING_RECTANGLE
  " :iab <buffer> gltbs GL_TEXTURE_BLUE_SIZE
  :iab <buffer> gltbs GL_TEXTURE_BUFFER_SIZE
  :iab <buffer> gltbt GL_TEXTURE_BLUE_TYPE
  :iab <buffer> gltcabb GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING
  :iab <buffer> gltca GL_TEXTURE_COORD_ARRAY
  :iab <buffer> gltcap GL_TEXTURE_COORD_ARRAY_POINTER
  " :iab <buffer> gltcas GL_TEXTURE_COORD_ARRAY_SIZE
  :iab <buffer> gltcas GL_TEXTURE_COORD_ARRAY_STRIDE
  :iab <buffer> gltcat GL_TEXTURE_COORD_ARRAY_TYPE
  :iab <buffer> gltcbh GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT
  :iab <buffer> gltcbs GL_TEXTURE_COMPRESSED_BLOCK_SIZE
  :iab <buffer> gltcbw GL_TEXTURE_COMPRESSED_BLOCK_WIDTH
  :iab <buffer> gltcf GL_TEXTURE_COMPARE_FUNC
  " :iab <buffer> gltc GL_TEXTURE_COMPONENTS
  :iab <buffer> gltc GL_TEXTURE_COMPRESSED
  :iab <buffer> gltch GL_TEXTURE_COMPRESSION_HINT
  :iab <buffer> gltcis GL_TEXTURE_COMPRESSED_IMAGE_SIZE
  :iab <buffer> gltcma GL_TEXTURE_CUBE_MAP_ARRAY
  " :iab <buffer> gltcm GL_TEXTURE_COMPARE_MODE
  " :iab <buffer> gltcm GL_TEXTURE_CUBE_MAP
  :iab <buffer> gltcm GL_TRANSPOSE_COLOR_MATRIX
  :iab <buffer> gltcmnx GL_TEXTURE_CUBE_MAP_NEGATIVE_X
  :iab <buffer> gltcmny GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
  :iab <buffer> gltcmnz GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
  :iab <buffer> gltcmpx GL_TEXTURE_CUBE_MAP_POSITIVE_X
  :iab <buffer> gltcmpy GL_TEXTURE_CUBE_MAP_POSITIVE_Y
  :iab <buffer> gltcmpz GL_TEXTURE_CUBE_MAP_POSITIVE_Z
  :iab <buffer> gltcms GL_TEXTURE_CUBE_MAP_SEAMLESS
  :iab <buffer> gltcov GL_TESS_CONTROL_OUTPUT_VERTICES
  :iab <buffer> gltcsb GL_TESS_CONTROL_SHADER_BIT
  " :iab <buffer> gltcs GL_TESS_CONTROL_SHADER
  :iab <buffer> gltcs GL_TESS_CONTROL_SUBROUTINE
  :iab <buffer> gltcsp GL_TESS_CONTROL_SHADER_PATCHES
  :iab <buffer> gltcsu GL_TESS_CONTROL_SUBROUTINE_UNIFORM
  :iab <buffer> gltct GL_TESS_CONTROL_TEXTURE
  :iab <buffer> gltd GL_TEXTURE_DEPTH
  :iab <buffer> gltds GL_TEXTURE_DEPTH_SIZE
  :iab <buffer> gltdt GL_TEXTURE_DEPTH_TYPE
  :iab <buffer> gltec GL_TEXTURE_ENV_COLOR
  " :iab <buffer> glte GL_TEXTURE_ENV
  " :iab <buffer> glte GL_TIME_ELAPSED
  :iab <buffer> glte GL_TIMEOUT_EXPIRED
  :iab <buffer> gltem GL_TEXTURE_ENV_MODE
  :iab <buffer> gltesb GL_TESS_EVALUATION_SHADER_BIT
  " :iab <buffer> gltes GL_TESS_EVALUATION_SHADER
  :iab <buffer> gltes GL_TESS_EVALUATION_SUBROUTINE
  :iab <buffer> gltesi GL_TESS_EVALUATION_SHADER_INVOCATIONS
  :iab <buffer> gltesu GL_TESS_EVALUATION_SUBROUTINE_UNIFORM
  :iab <buffer> gltet GL_TESS_EVALUATION_TEXTURE
  :iab <buffer> gltfa GL_TRANSFORM_FEEDBACK_ACTIVE
  :iab <buffer> gltfba GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE
  " :iab <buffer> gltfbb GL_TEXTURE_FETCH_BARRIER_BIT
  " :iab <buffer> gltfbb GL_TRANSFORM_FEEDBACK_BARRIER_BIT
  :iab <buffer> gltfbb GL_TRANSFORM_FEEDBACK_BUFFER_BINDING
  " :iab <buffer> gltfb GL_TRANSFORM_FEEDBACK_BINDING
  :iab <buffer> gltfb GL_TRANSFORM_FEEDBACK_BUFFER
  :iab <buffer> gltfbi GL_TRANSFORM_FEEDBACK_BUFFER_INDEX
  :iab <buffer> gltfbm GL_TRANSFORM_FEEDBACK_BUFFER_MODE
  :iab <buffer> gltfbp GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED
  " :iab <buffer> gltfbs GL_TRANSFORM_FEEDBACK_BUFFER_SIZE
  " :iab <buffer> gltfbs GL_TRANSFORM_FEEDBACK_BUFFER_START
  :iab <buffer> gltfbs GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE
  :iab <buffer> gltfc GL_TEXTURE_FILTER_CONTROL
  " :iab <buffer> gltf GL_TRANSFORM_FEEDBACK
  :iab <buffer> gltf GL_TRIANGLE_FAN
  :iab <buffer> gltfo GL_TRANSFORM_FEEDBACK_OVERFLOW
  :iab <buffer> gltfp GL_TRANSFORM_FEEDBACK_PAUSED
  :iab <buffer> gltfpw GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN
  :iab <buffer> gltfsl GL_TEXTURE_FIXED_SAMPLE_LOCATIONS
  :iab <buffer> gltfso GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW
  " :iab <buffer> gltfv GL_TRANSFORM_FEEDBACK_VARYING
  :iab <buffer> gltfv GL_TRANSFORM_FEEDBACK_VARYINGS
  :iab <buffer> gltfvml GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH
  :iab <buffer> gltg GL_TEXTURE_GATHER
  " :iab <buffer> gltgm GL_TESS_GEN_MODE
  :iab <buffer> gltgm GL_TEXTURE_GEN_MODE
  :iab <buffer> gltgpm GL_TESS_GEN_POINT_MODE
  :iab <buffer> gltgq GL_TEXTURE_GEN_Q
  :iab <buffer> gltgr GL_TEXTURE_GEN_R
  " :iab <buffer> gltgs GL_TESS_GEN_SPACING
  " :iab <buffer> gltgs GL_TEXTURE_GATHER_SHADOW
  " :iab <buffer> gltgs GL_TEXTURE_GEN_S
  :iab <buffer> gltgs GL_TEXTURE_GREEN_SIZE
  " :iab <buffer> gltgt GL_TEXTURE_GEN_T
  :iab <buffer> gltgt GL_TEXTURE_GREEN_TYPE
  :iab <buffer> gltgvo GL_TESS_GEN_VERTEX_ORDER
  :iab <buffer> glth GL_TEXTURE_HEIGHT
  " :iab <buffer> gltif GL_TEXTURE_IMAGE_FORMAT
  " :iab <buffer> gltif GL_TEXTURE_IMMUTABLE_FORMAT
  :iab <buffer> gltif GL_TEXTURE_INTERNAL_FORMAT
  :iab <buffer> glti GL_TIMEOUT_IGNORED
  :iab <buffer> gltil GL_TEXTURE_IMMUTABLE_LEVELS
  :iab <buffer> gltis GL_TEXTURE_INTENSITY_SIZE
  " :iab <buffer> gltit GL_TEXTURE_IMAGE_TYPE
  :iab <buffer> gltit GL_TEXTURE_INTENSITY_TYPE
  " :iab <buffer> gltlas GL_TOP_LEVEL_ARRAY_SIZE
  :iab <buffer> gltlas GL_TOP_LEVEL_ARRAY_STRIDE
  :iab <buffer> gltlb GL_TEXTURE_LOD_BIAS
  :iab <buffer> gltls GL_TEXTURE_LUMINANCE_SIZE
  :iab <buffer> gltlt GL_TEXTURE_LUMINANCE_TYPE
  :iab <buffer> gltma GL_TEXTURE_MAX_ANISOTROPY
  " :iab <buffer> gltmf GL_TEXTURE_MAG_FILTER
  :iab <buffer> gltmf GL_TEXTURE_MIN_FILTER
  :iab <buffer> gltm GL_TEXTURE_MATRIX
  " :iab <buffer> gltml GL_TEXTURE_MAX_LEVEL
  " :iab <buffer> gltml GL_TEXTURE_MAX_LOD
  :iab <buffer> gltml GL_TEXTURE_MIN_LOD
  :iab <buffer> gltmm GL_TRANSPOSE_MODELVIEW_MATRIX
  :iab <buffer> gltp GL_TEXTURE_PRIORITY
  :iab <buffer> gltpm GL_TRANSPOSE_PROJECTION_MATRIX
  " :iab <buffer> gltr GL_TEXTURE_RECTANGLE
  :iab <buffer> gltr GL_TEXTURE_RESIDENT
  :iab <buffer> gltrs GL_TEXTURE_RED_SIZE
  :iab <buffer> gltrt GL_TEXTURE_RED_TYPE
  " :iab <buffer> gltsa GL_TEXTURE_SWIZZLE_A
  :iab <buffer> gltsa GL_TRIANGLE_STRIP_ADJACENCY
  :iab <buffer> gltsb GL_TEXTURE_SWIZZLE_B
  :iab <buffer> gltsd GL_TEXTURE_STACK_DEPTH
  :iab <buffer> gltsg GL_TEXTURE_SWIZZLE_G
  " :iab <buffer> glts GL_TEXTURE_SAMPLES
  " :iab <buffer> glts GL_TEXTURE_SHADOW
  :iab <buffer> glts GL_TRIANGLE_STRIP
  " :iab <buffer> gltsr GL_TEXTURE_SWIZZLE_R
  :iab <buffer> gltsr GL_TEXTURE_SWIZZLE_RGBA
  " :iab <buffer> gltss GL_TEXTURE_SHARED_SIZE
  :iab <buffer> gltss GL_TEXTURE_STENCIL_SIZE
  :iab <buffer> gltt GL_TEXTURE_TARGET
  :iab <buffer> glttl GL_TABLE_TOO_LARGE
  :iab <buffer> glttm GL_TRANSPOSE_TEXTURE_MATRIX
  :iab <buffer> gltubb GL_TEXTURE_UPDATE_BARRIER_BIT
  :iab <buffer> gltv GL_TEXTURE_VIEW
  " :iab <buffer> gltvml GL_TEXTURE_VIEW_MIN_LAYER
  :iab <buffer> gltvml GL_TEXTURE_VIEW_MIN_LEVEL
  " :iab <buffer> gltvnl GL_TEXTURE_VIEW_NUM_LAYERS
  :iab <buffer> gltvnl GL_TEXTURE_VIEW_NUM_LEVELS
  :iab <buffer> gltw GL_TEXTURE_WIDTH
  :iab <buffer> gltwr GL_TEXTURE_WRAP_R
  :iab <buffer> gltws GL_TEXTURE_WRAP_S
  :iab <buffer> gltwt GL_TEXTURE_WRAP_T
  :iab <buffer> gluacbi GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX
  :iab <buffer> glua GL_UNPACK_ALIGNMENT
  :iab <buffer> gluas GL_UNIFORM_ARRAY_STRIDE
  :iab <buffer> glub233r GL_UNSIGNED_BYTE_2_3_3_REV
  :iab <buffer> glub332 GL_UNSIGNED_BYTE_3_3_2
  :iab <buffer> glubau GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS
  :iab <buffer> glubaui GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES
  " :iab <buffer> glubb GL_UNIFORM_BARRIER_BIT
  " :iab <buffer> glubb GL_UNIFORM_BLOCK_BINDING
  :iab <buffer> glubb GL_UNIFORM_BUFFER_BINDING
  :iab <buffer> glubds GL_UNIFORM_BLOCK_DATA_SIZE
  " :iab <buffer> glub GL_UNIFORM_BLOCK
  " :iab <buffer> glub GL_UNIFORM_BUFFER
  :iab <buffer> glub GL_UNSIGNED_BYTE
  :iab <buffer> glubi GL_UNIFORM_BLOCK_INDEX
  :iab <buffer> glubnl GL_UNIFORM_BLOCK_NAME_LENGTH
  :iab <buffer> gluboa GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT
  :iab <buffer> glubrbcs GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER
  :iab <buffer> glubrbfs GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER
  :iab <buffer> glubrbgs GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER
  :iab <buffer> glubrbtcs GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER
  :iab <buffer> glubrbtes GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER
  :iab <buffer> glubrbvs GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER
  " :iab <buffer> glubs GL_UNIFORM_BUFFER_SIZE
  :iab <buffer> glubs GL_UNIFORM_BUFFER_START
  :iab <buffer> glucbd GL_UNPACK_COMPRESSED_BLOCK_DEPTH
  :iab <buffer> glucbh GL_UNPACK_COMPRESSED_BLOCK_HEIGHT
  :iab <buffer> glucbs GL_UNPACK_COMPRESSED_BLOCK_SIZE
  :iab <buffer> glucbw GL_UNPACK_COMPRESSED_BLOCK_WIDTH
  :iab <buffer> glucr GL_UNKNOWN_CONTEXT_RESET
  :iab <buffer> glui1010102 GL_UNSIGNED_INT_10_10_10_2
  :iab <buffer> glui10f11f11fr GL_UNSIGNED_INT_10F_11F_11F_REV
  :iab <buffer> glui2101010r GL_UNSIGNED_INT_2_10_10_10_REV
  :iab <buffer> glui248 GL_UNSIGNED_INT_24_8
  :iab <buffer> glui5999r GL_UNSIGNED_INT_5_9_9_9_REV
  :iab <buffer> glui8888 GL_UNSIGNED_INT_8_8_8_8
  :iab <buffer> glui8888r GL_UNSIGNED_INT_8_8_8_8_REV
  :iab <buffer> gluiac GL_UNSIGNED_INT_ATOMIC_COUNTER
  :iab <buffer> glui GL_UNSIGNED_INT
  :iab <buffer> gluih GL_UNPACK_IMAGE_HEIGHT
  :iab <buffer> gluii1da GL_UNSIGNED_INT_IMAGE_1D_ARRAY
  :iab <buffer> gluii1d GL_UNSIGNED_INT_IMAGE_1D
  :iab <buffer> gluii2da GL_UNSIGNED_INT_IMAGE_2D_ARRAY
  :iab <buffer> gluii2d GL_UNSIGNED_INT_IMAGE_2D
  :iab <buffer> gluii2dma GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY
  :iab <buffer> gluii2dm GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE
  :iab <buffer> gluii2dr GL_UNSIGNED_INT_IMAGE_2D_RECT
  :iab <buffer> gluii3d GL_UNSIGNED_INT_IMAGE_3D
  :iab <buffer> gluiib GL_UNSIGNED_INT_IMAGE_BUFFER
  :iab <buffer> gluiic GL_UNSIGNED_INT_IMAGE_CUBE
  :iab <buffer> gluiicma GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY
  :iab <buffer> gluirm GL_UNIFORM_IS_ROW_MAJOR
  :iab <buffer> gluis1da GL_UNSIGNED_INT_SAMPLER_1D_ARRAY
  :iab <buffer> gluis1d GL_UNSIGNED_INT_SAMPLER_1D
  :iab <buffer> gluis2da GL_UNSIGNED_INT_SAMPLER_2D_ARRAY
  :iab <buffer> gluis2d GL_UNSIGNED_INT_SAMPLER_2D
  :iab <buffer> gluis2dma GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY
  :iab <buffer> gluis2dm GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE
  :iab <buffer> gluis2dr GL_UNSIGNED_INT_SAMPLER_2D_RECT
  :iab <buffer> gluis3d GL_UNSIGNED_INT_SAMPLER_3D
  :iab <buffer> gluisb GL_UNSIGNED_INT_SAMPLER_BUFFER
  :iab <buffer> gluisc GL_UNSIGNED_INT_SAMPLER_CUBE
  :iab <buffer> gluiscma GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY
  :iab <buffer> gluiv2 GL_UNSIGNED_INT_VEC2
  :iab <buffer> gluiv3 GL_UNSIGNED_INT_VEC3
  :iab <buffer> gluiv4 GL_UNSIGNED_INT_VEC4
  :iab <buffer> glulf GL_UNPACK_LSB_FIRST
  :iab <buffer> glul GL_UPPER_LEFT
  :iab <buffer> glums GL_UNIFORM_MATRIX_STRIDE
  :iab <buffer> glun GL_UNSIGNED_NORMALIZED
  :iab <buffer> glunl GL_UNIFORM_NAME_LENGTH
  :iab <buffer> gluo GL_UNIFORM_OFFSET
  :iab <buffer> glurl GL_UNPACK_ROW_LENGTH
  :iab <buffer> glus1555r GL_UNSIGNED_SHORT_1_5_5_5_REV
  :iab <buffer> glus4444 GL_UNSIGNED_SHORT_4_4_4_4
  :iab <buffer> glus4444r GL_UNSIGNED_SHORT_4_4_4_4_REV
  :iab <buffer> glus5551 GL_UNSIGNED_SHORT_5_5_5_1
  :iab <buffer> glus565 GL_UNSIGNED_SHORT_5_6_5
  :iab <buffer> glus565r GL_UNSIGNED_SHORT_5_6_5_REV
  :iab <buffer> glusb GL_UNPACK_SWAP_BYTES
  " :iab <buffer> glus GL_UNIFORM_SIZE
  :iab <buffer> glus GL_UNSIGNED_SHORT
  :iab <buffer> glusi GL_UNPACK_SKIP_IMAGES
  :iab <buffer> glusp GL_UNPACK_SKIP_PIXELS
  :iab <buffer> glusr GL_UNPACK_SKIP_ROWS
  :iab <buffer> glut GL_UNIFORM_TYPE
  :iab <buffer> gluv GL_UNDEFINED_VERTEX
  " :iab <buffer> glvaabb GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT
  :iab <buffer> glvaabb GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING
  :iab <buffer> glvaad GL_VERTEX_ATTRIB_ARRAY_DIVISOR
  :iab <buffer> glvaae GL_VERTEX_ATTRIB_ARRAY_ENABLED
  :iab <buffer> glvaai GL_VERTEX_ATTRIB_ARRAY_INTEGER
  :iab <buffer> glvaal GL_VERTEX_ATTRIB_ARRAY_LONG
  :iab <buffer> glvaan GL_VERTEX_ATTRIB_ARRAY_NORMALIZED
  :iab <buffer> glvaap GL_VERTEX_ATTRIB_ARRAY_POINTER
  " :iab <buffer> glvaas GL_VERTEX_ATTRIB_ARRAY_SIZE
  :iab <buffer> glvaas GL_VERTEX_ATTRIB_ARRAY_STRIDE
  :iab <buffer> glvaat GL_VERTEX_ATTRIB_ARRAY_TYPE
  :iab <buffer> glvabb GL_VERTEX_ARRAY_BUFFER_BINDING
  " :iab <buffer> glvab GL_VERTEX_ARRAY_BINDING
  :iab <buffer> glvab GL_VERTEX_ATTRIB_BINDING
  :iab <buffer> glva GL_VERTEX_ARRAY
  :iab <buffer> glvap GL_VERTEX_ARRAY_POINTER
  :iab <buffer> glvaro GL_VERTEX_ATTRIB_RELATIVE_OFFSET
  " :iab <buffer> glvas GL_VERTEX_ARRAY_SIZE
  :iab <buffer> glvas GL_VERTEX_ARRAY_STRIDE
  :iab <buffer> glvat GL_VERTEX_ARRAY_TYPE
  :iab <buffer> glvbb GL_VERTEX_BINDING_BUFFER
  :iab <buffer> glvbd GL_VERTEX_BINDING_DIVISOR
  :iab <buffer> glvb GL_VIEWPORT_BIT
  :iab <buffer> glvbo GL_VERTEX_BINDING_OFFSET
  :iab <buffer> glvbr GL_VIEWPORT_BOUNDS_RANGE
  :iab <buffer> glvbs GL_VERTEX_BINDING_STRIDE
  :iab <buffer> glvc128b GL_VIEW_CLASS_128_BITS
  :iab <buffer> glvc16b GL_VIEW_CLASS_16_BITS
  :iab <buffer> glvc24b GL_VIEW_CLASS_24_BITS
  :iab <buffer> glvc32b GL_VIEW_CLASS_32_BITS
  :iab <buffer> glvc48b GL_VIEW_CLASS_48_BITS
  :iab <buffer> glvc64b GL_VIEW_CLASS_64_BITS
  :iab <buffer> glvc8b GL_VIEW_CLASS_8_BITS
  :iab <buffer> glvc96b GL_VIEW_CLASS_96_BITS
  :iab <buffer> glvcbf GL_VIEW_CLASS_BPTC_FLOAT
  :iab <buffer> glvcbu GL_VIEW_CLASS_BPTC_UNORM
  :iab <buffer> glvcc GL_VIEW_COMPATIBILITY_CLASS
  :iab <buffer> glvcr1r GL_VIEW_CLASS_RGTC1_RED
  :iab <buffer> glvcr2r GL_VIEW_CLASS_RGTC2_RG
  " :iab <buffer> glvcs3tcd1r GL_VIEW_CLASS_S3TC_DXT1_RGB
  :iab <buffer> glvcs3tcd1r GL_VIEW_CLASS_S3TC_DXT1_RGBA
  :iab <buffer> glvcs3tcd3r GL_VIEW_CLASS_S3TC_DXT3_RGBA
  :iab <buffer> glvcs3tcd5r GL_VIEW_CLASS_S3TC_DXT5_RGBA
  :iab <buffer> glvipv GL_VIEWPORT_INDEX_PROVOKING_VERTEX
  :iab <buffer> glvpps GL_VERTEX_PROGRAM_POINT_SIZE
  :iab <buffer> glvpts GL_VERTEX_PROGRAM_TWO_SIDE
  " :iab <buffer> glvsb GL_VERTEX_SHADER_BIT
  :iab <buffer> glvsb GL_VIEWPORT_SUBPIXEL_BITS
  " :iab <buffer> glvs GL_VALIDATE_STATUS
  " :iab <buffer> glvs GL_VERTEX_SHADER
  " :iab <buffer> glvs GL_VERTEX_SUBROUTINE
  :iab <buffer> glvs GL_VERTICES_SUBMITTED
  :iab <buffer> glvsi GL_VERTEX_SHADER_INVOCATIONS
  :iab <buffer> glvsu GL_VERTEX_SUBROUTINE_UNIFORM
  :iab <buffer> glvt GL_VERTEX_TEXTURE
  :iab <buffer> glwabb GL_WEIGHT_ARRAY_BUFFER_BINDING
  :iab <buffer> glwf GL_WAIT_FAILED
  :iab <buffer> glwo GL_WRITE_ONLY
  :iab <buffer> glzto GL_ZERO_TO_ONE
  :iab <buffer> glzx GL_ZOOM_X
  :iab <buffer> glzy GL_ZOOM_Y

  " manual
  :iab <buffer> gll GL_LIGHTING
  :iab <buffer> glps GL_POINT_SIZE
  :iab <buffer> glab GL_ARRAY_BUFFER
  :iab <buffer> glcbb GL_COLOR_BUFFER_BIT
  :iab <buffer> glca GL_CONSTANT_ALPHA
  :iab <buffer> glvs GL_VERTEX_SHADER
  :iab <buffer> glfs GL_FRAGMENT_SHADER
  :iab <buffer> glcs GL_COMPUTE_SHADER
  :iab <buffer> gltcs GL_TESS_CONTROL_SHADER
  :iab <buffer> gltes GL_TESS_EVALUATION_SHADER
  :iab <buffer> glsa GL_SRC_ALPHA
  :iab <buffer> glppb GL_PIXEL_PACK_BUFFER
  :iab <buffer> glls GL_LINE_SMOOTH
  :iab <buffer> glsd GL_STATIC_DRAW
  :iab <buffer> glsr GL_STATIC_READ
  :iab <buffer> glsc GL_STATIC_COPY

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
  :iab <buffer> glcd GLclampd

  :iab <buffer> glbt glBindTexture

endfunction

function abbre#mygui()
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

function abbre#osg()
  :iab <buffer> oaf osg::AlphaFunc
  :iab <buffer> oap osg::AnimationPath
  :iab <buffer> oapc osg::AnimationPathCallback
  :iab <buffer> oau osg::ApplicationUsage
  :iab <buffer> oaup osg::ApplicationUsageProxy
  :iab <buffer> oap osg::ArgumentParser
  :iab <buffer> oa osg::Array
  :iab <buffer> ota osg::TemplateArray
  :iab <buffer> oia osg::IndexArray
  :iab <buffer> otia osg::TemplateIndexArray
  :iab <buffer> oav osg::ArrayVisitor
  :iab <buffer> ocav osg::ConstArrayVisitor
  :iab <buffer> ovv osg::ValueVisitor
  :iab <buffer> ocvv osg::ConstValueVisitor
  :iab <buffer> oad osg::AttributeDispatch
  :iab <buffer> oad osg::AttributeDispatchers
  :iab <buffer> oas osg::AudioSink
  :iab <buffer> oas osg::AudioStream
  :iab <buffer> oat osg::AutoTransform
  :iab <buffer> ob osg::Billboard
  :iab <buffer> obit osg::BindImageTexture
  :iab <buffer> obc osg::BlendColor
  :iab <buffer> obe osg::BlendEquation
  :iab <buffer> obe osg::BlendEquationi
  :iab <buffer> obf osg::BlendFunc
  :iab <buffer> obf osg::BlendFunci
  :iab <buffer> obbi osg::BoundingBoxImpl
  :iab <buffer> obsi osg::BoundingSphereImpl
  :iab <buffer> o_ osg::buffered_value
  :iab <buffer> o_ osg::buffered_object
  :iab <buffer> obib osg::BufferIndexBinding
  :iab <buffer> oubb osg::UniformBufferBinding
  :iab <buffer> otfbb osg::TransformFeedbackBufferBinding
  :iab <buffer> oacbb osg::AtomicCounterBufferBinding
  :iab <buffer> ossbb osg::ShaderStorageBufferBinding
  :iab <buffer> obop osg::BufferObjectProfile
  :iab <buffer> oglbo osg::GLBufferObject
  :iab <buffer> oglbos osg::GLBufferObjectSet
  :iab <buffer> oglbom osg::GLBufferObjectManager
  :iab <buffer> obo osg::BufferObject
  :iab <buffer> obd osg::BufferData
  :iab <buffer> ovbo osg::VertexBufferObject
  :iab <buffer> oebo osg::ElementBufferObject
  :iab <buffer> odibo osg::DrawIndirectBufferObject
  :iab <buffer> opbo osg::PixelBufferObject
  :iab <buffer> opdbo osg::PixelDataBufferObject
  :iab <buffer> oubo osg::UniformBufferObject
  :iab <buffer> oacbo osg::AtomicCounterBufferObject
  :iab <buffer> ossbo osg::ShaderStorageBufferObject
  :iab <buffer> obt osg::BufferTemplate
  :iab <buffer> obt osg::BufferTemplate
  :iab <buffer> oc osg::Callback
  :iab <buffer> oco osg::CallbackObject
  :iab <buffer> onc osg::NodeCallback
  :iab <buffer> osac osg::StateAttributeCallback
  :iab <buffer> ouc osg::UniformCallback
  :iab <buffer> oduc osg::DrawableUpdateCallback
  :iab <buffer> odec osg::DrawableEventCallback
  :iab <buffer> odcc osg::DrawableCullCallback
  :iab <buffer> oc osg::Camera
  :iab <buffer> ocroso osg::CameraRenderOrderSortOp
  :iab <buffer> ocv osg::CameraView
  :iab <buffer> oc osg::Capability
  :iab <buffer> oc osg::Capabilityi
  :iab <buffer> oe osg::Enablei
  :iab <buffer> od osg::Disablei
  :iab <buffer> occ osg::ClampColor
  :iab <buffer> ocn osg::ClearNode
  :iab <buffer> occ osg::ClipControl
  :iab <buffer> ocn osg::ClipNode
  :iab <buffer> ocp osg::ClipPlane
  :iab <buffer> occc osg::ClusterCullingCallback
  :iab <buffer> ocov osg::CollectOccludersVisitor
  :iab <buffer> ocm osg::ColorMask
  :iab <buffer> ocm osg::ColorMaski
  :iab <buffer> ocm osg::ColorMatrix
  :iab <buffer> ocbv osg::ComputeBoundsVisitor
  :iab <buffer> ocd osg::ContextData
  :iab <buffer> ocpo osg::ConvexPlanarOccluder
  :iab <buffer> ocpp osg::ConvexPlanarPolygon
  :iab <buffer> oem osg::EllipsoidModel
  :iab <buffer> ocsn osg::CoordinateSystemNode
  :iab <buffer> oco osg::CopyOp
  :iab <buffer> ocf osg::CullFace
  :iab <buffer> ocs osg::CullingSet
  :iab <buffer> ocs osg::CullSettings
  :iab <buffer> ocs osg::CullStack
  :iab <buffer> odh osg::DeleteHandler
  :iab <buffer> od osg::Depth
  :iab <buffer> odri osg::DepthRangeIndexed
  :iab <buffer> odc osg::DispatchCompute
  :iab <buffer> ods osg::DisplaySettings
  :iab <buffer> od osg::Drawable
  :iab <buffer> oafav osg::AttributeFunctorArrayVisitor
  :iab <buffer> ocafav osg::ConstAttributeFunctorArrayVisitor
  :iab <buffer> odp osg::DrawPixels
  :iab <buffer> o__ osg::fast_back_stack
  :iab <buffer> of osg::Fog
  :iab <buffer> ofp osg::FragmentProgram
  :iab <buffer> orb osg::RenderBuffer
  :iab <buffer> ofba osg::FrameBufferAttachment
  :iab <buffer> ofbo osg::FrameBufferObject
  :iab <buffer> oglrbm osg::GLRenderBufferManager
  :iab <buffer> oglfbom osg::GLFrameBufferObjectManager
  :iab <buffer> ofs osg::FrameStamp
  :iab <buffer> off osg::FrontFace
  :iab <buffer> og osg::Geode
  :iab <buffer> og osg::Geometry
  :iab <buffer> ocbov osg::ConfigureBufferObjectsVisitor
  :iab <buffer> ovaa osg::VertexAttribAlias
  :iab <buffer> ogle osg::GLExtensions
  :iab <buffer> ogo osg::GraphicsObject
  :iab <buffer> ogom osg::GraphicsObjectManager
  :iab <buffer> oglom osg::GLObjectManager
  :iab <buffer> opsm osg::PixelStorageModes
  :iab <buffer> ogc osg::GraphicsContext
  :iab <buffer> ossbc osg::SyncSwapBuffersCallback
  :iab <buffer> owsip osg::WindowingSystemInterfaceProxy
  :iab <buffer> oclcf1d osg::ClampedLinearCostFunction1D
  :iab <buffer> ogce osg::GeometryCostEstimator
  :iab <buffer> otce osg::TextureCostEstimator
  :iab <buffer> opce osg::ProgramCostEstimator
  :iab <buffer> ogce osg::GraphicsCostEstimator
  :iab <buffer> ogt osg::GraphicsThread
  :iab <buffer> ogo osg::GraphicsOperation
  :iab <buffer> osbo osg::SwapBuffersOperation
  :iab <buffer> obo osg::BarrierOperation
  :iab <buffer> orc_b_mco osg::ReleaseContext_Block_MakeCurrentOperation
  :iab <buffer> obafo osg::BlockAndFlushOperation
  :iab <buffer> ofdgloo osg::FlushDeletedGLObjectsOperation
  :iab <buffer> oro osg::RunOperations
  :iab <buffer> oeoddb osg::EndOfDynamicDrawBlock
  :iab <buffer> og osg::Group
  :iab <buffer> oh osg::Hint
  :iab <buffer> oi osg::Identifier
  :iab <buffer> oi osg::Image
  :iab <buffer> ois osg::ImageSequence
  :iab <buffer> ois osg::ImageStream
  :iab <buffer> ocastfo osg::CastAndScaleToFloatOperation
  :iab <buffer> oms osg::MakeString
  :iab <buffer> okt osg::KdTree
  :iab <buffer> oktb osg::KdTreeBuilder
  :iab <buffer> ol osg::Light
  :iab <buffer> olm osg::LightModel
  :iab <buffer> ols osg::LightSource
  :iab <buffer> ols osg::LineSegment
  :iab <buffer> ols osg::LineStipple
  :iab <buffer> olw osg::LineWidth
  :iab <buffer> olod osg::LOD
  :iab <buffer> olo osg::LogicOp
  :iab <buffer> om osg::Material
  :iab <buffer> om osg::Matrixd
  :iab <buffer> orm osg::RefMatrixd
  :iab <buffer> om osg::Matrixf
  :iab <buffer> orm osg::RefMatrixf
  :iab <buffer> otm osg::TemplateMatrix
  :iab <buffer> om2t osg::Matrix2Template
  :iab <buffer> om23t osg::Matrix2x3Template
  :iab <buffer> om24t osg::Matrix2x4Template
  :iab <buffer> om32t osg::Matrix3x2Template
  :iab <buffer> om3t osg::Matrix3Template
  :iab <buffer> om34t osg::Matrix3x4Template
  :iab <buffer> om42t osg::Matrix4x2Template
  :iab <buffer> om43t osg::Matrix4x3Template
  :iab <buffer> omt osg::MatrixTransform
  :iab <buffer> omv osg::MixinVector
  :iab <buffer> om osg::Multisample
  :iab <buffer> on osg::Node
  :iab <buffer> ontc osg::NodeTrackerCallback
  :iab <buffer> onv osg::NodeVisitor
  :iab <buffer> onao osg::NodeAcceptOp
  :iab <buffer> oppo osg::PushPopObject
  :iab <buffer> oppv osg::PushPopValue
  :iab <buffer> onh osg::NotifyHandler
  :iab <buffer> osnh osg::StandardNotifyHandler
  :iab <buffer> owdnh osg::WinDebugNotifyHandler
  :iab <buffer> oo osg::Object
  :iab <buffer> odo osg::DummyObject
  :iab <buffer> oo osg::Observer
  :iab <buffer> oos osg::ObserverSet
  :iab <buffer> oonp osg::ObserverNodePath
  :iab <buffer> o_ osg::observer_ptr
  :iab <buffer> oon osg::OccluderNode
  :iab <buffer> otr osg::TestResult
  :iab <buffer> oqg osg::QueryGeometry
  :iab <buffer> ooqn osg::OcclusionQueryNode
  :iab <buffer> orb osg::RefBlock
  :iab <buffer> orbc osg::RefBlockCount
  :iab <buffer> oo osg::Operation
  :iab <buffer> ooq osg::OperationQueue
  :iab <buffer> oot osg::OperationThread
  :iab <buffer> oplod osg::PagedLOD
  :iab <buffer> opp osg::PatchParameter
  :iab <buffer> op osg::Plane
  :iab <buffer> op osg::Point
  :iab <buffer> ops osg::PointSprite
  :iab <buffer> opm osg::PolygonMode
  :iab <buffer> opo osg::PolygonOffset
  :iab <buffer> ops osg::PolygonStipple
  :iab <buffer> op osg::Polytope
  :iab <buffer> opat osg::PositionAttitudeTransform
  :iab <buffer> opri osg::PrimitiveRestartIndex
  :iab <buffer> opf osg::PrimitiveFunctor
  :iab <buffer> opif osg::PrimitiveIndexFunctor
  :iab <buffer> ops osg::PrimitiveSet
  :iab <buffer> oda osg::DrawArrays
  :iab <buffer> odal osg::DrawArrayLengths
  :iab <buffer> ode osg::DrawElements
  :iab <buffer> odeub osg::DrawElementsUByte
  :iab <buffer> odeus osg::DrawElementsUShort
  :iab <buffer> odeui osg::DrawElementsUInt
  :iab <buffer> omda osg::MultiDrawArrays
  :iab <buffer> oicda osg::IndirectCommandDrawArrays
  :iab <buffer> oicde osg::IndirectCommandDrawElements
  :iab <buffer> odaic osg::DrawArraysIndirectCommand
  :iab <buffer> odicda osg::DefaultIndirectCommandDrawArrays
  :iab <buffer> odeic osg::DrawElementsIndirectCommand
  :iab <buffer> odicde osg::DefaultIndirectCommandDrawElements
  :iab <buffer> odei osg::DrawElementsIndirect
  :iab <buffer> odeiub osg::DrawElementsIndirectUByte
  :iab <buffer> odeius osg::DrawElementsIndirectUShort
  :iab <buffer> odeiui osg::DrawElementsIndirectUInt
  :iab <buffer> omdeius osg::MultiDrawElementsIndirectUShort
  :iab <buffer> omdeiub osg::MultiDrawElementsIndirectUByte
  :iab <buffer> omdeiui osg::MultiDrawElementsIndirectUInt
  :iab <buffer> odai osg::DrawArraysIndirect
  :iab <buffer> omdai osg::MultiDrawArraysIndirect
  :iab <buffer> op osg::Program
  :iab <buffer> op osg::Projection
  :iab <buffer> opn osg::ProxyNode
  :iab <buffer> oq osg::Quat
  :iab <buffer> o_ osg::depends_on
  :iab <buffer> or osg::Referenced
  :iab <buffer> o_ osg::ref_ptr
  :iab <buffer> ori osg::RenderInfo
  :iab <buffer> osm osg::SampleMaski
  :iab <buffer> os osg::Sampler
  :iab <buffer> os osg::Scissor
  :iab <buffer> osi osg::ScissorIndexed
  :iab <buffer> os osg::Script
  :iab <buffer> osnc osg::ScriptNodeCallback
  :iab <buffer> ose osg::ScriptEngine
  :iab <buffer> os osg::Sequence
  :iab <buffer> osm osg::ShadeModel
  :iab <buffer> osp osg::ShaderPragmas
  :iab <buffer> osb osg::ShaderBinary
  :iab <buffer> os osg::Shader
  :iab <buffer> osc osg::ShaderComponent
  :iab <buffer> osa osg::ShaderAttribute
  :iab <buffer> osc osg::ShaderComposer
  :iab <buffer> osvo osg::ShadowVolumeOccluder
  :iab <buffer> os osg::Shape
  :iab <buffer> osv osg::ShapeVisitor
  :iab <buffer> ocsv osg::ConstShapeVisitor
  :iab <buffer> os osg::Sphere
  :iab <buffer> ob osg::Box
  :iab <buffer> oc osg::Cone
  :iab <buffer> oc osg::Cylinder
  :iab <buffer> oc osg::Capsule
  :iab <buffer> oip osg::InfinitePlane
  :iab <buffer> otm osg::TriangleMesh
  :iab <buffer> och osg::ConvexHull
  :iab <buffer> ohf osg::HeightField
  :iab <buffer> ocs osg::CompositeShape
  :iab <buffer> oth osg::TessellationHints
  :iab <buffer> obsgv osg::BuildShapeGeometryVisitor
  :iab <buffer> osd osg::ShapeDrawable
  :iab <buffer> os osg::State
  :iab <buffer> osa osg::StateAttribute
  :iab <buffer> oss osg::StateSet
  :iab <buffer> os osg::Stats
  :iab <buffer> os osg::Stencil
  :iab <buffer> osts osg::StencilTwoSided
  :iab <buffer> os osg::Switch
  :iab <buffer> otpf osg::TemplatePrimitiveFunctor
  :iab <buffer> otpif osg::TemplatePrimitiveIndexFunctor
  :iab <buffer> ote osg::TexEnv
  :iab <buffer> otec osg::TexEnvCombine
  :iab <buffer> otef osg::TexEnvFilter
  :iab <buffer> otg osg::TexGen
  :iab <buffer> otgn osg::TexGenNode
  :iab <buffer> otm osg::TexMat
  :iab <buffer> ot osg::Texture
  :iab <buffer> otos osg::TextureObjectSet
  :iab <buffer> otom osg::TextureObjectManager
  :iab <buffer> ot1d osg::Texture1D
  :iab <buffer> ot2d osg::Texture2D
  :iab <buffer> ot2da osg::Texture2DArray
  :iab <buffer> ot2dm osg::Texture2DMultisample
  :iab <buffer> ot3d osg::Texture3D
  :iab <buffer> ota osg::TextureAttribute
  :iab <buffer> otb osg::TextureBuffer
  :iab <buffer> otcm osg::TextureCubeMap
  :iab <buffer> otr osg::TextureRectangle
  :iab <buffer> ot osg::Timer
  :iab <buffer> oet osg::ElapsedTime
  :iab <buffer> otf osg::TransferFunction
  :iab <buffer> otf1d osg::TransferFunction1D
  :iab <buffer> ot osg::Transform
  :iab <buffer> otf osg::TriangleFunctor
  :iab <buffer> otif osg::TriangleIndexFunctor
  :iab <buffer> otlpif osg::TriangleLinePointIndexFunctor
  :iab <buffer> oucnt osg::UniformClassNameTrait
  :iab <buffer> otu osg::TemplateUniform
  :iab <buffer> oaucnt osg::ArrayUniformClassNameTrait
  :iab <buffer> otau osg::TemplateArrayUniform
  :iab <buffer> ou osg::Uniform
  :iab <buffer> oub osg::UniformBase
  :iab <buffer> oudc osg::UserDataContainer
  :iab <buffer> odudc osg::DefaultUserDataContainer
  :iab <buffer> ovm osg::ValueMap
  :iab <buffer> ovo osg::ValueObject
  :iab <buffer> ogsv osg::GetScalarValue
  :iab <buffer> ogsv osg::GetScalarValue
  :iab <buffer> ossv osg::SetScalarValue
  :iab <buffer> ovocnt osg::ValueObjectClassNameTrait
  :iab <buffer> otvo osg::TemplateValueObject
  :iab <buffer> ovs osg::ValueStack
  :iab <buffer> ov2 osg::Vec2b
  :iab <buffer> ov2 osg::Vec2d
  :iab <buffer> ov2 osg::Vec2f
  :iab <buffer> ov2 osg::Vec2i
  :iab <buffer> ov2 osg::Vec2s
  :iab <buffer> ov2 osg::Vec2ub
  :iab <buffer> ov2 osg::Vec2ui
  :iab <buffer> ov2 osg::Vec2us
  :iab <buffer> ov3 osg::Vec3b
  :iab <buffer> ov3 osg::Vec3d
  :iab <buffer> ov3 osg::Vec3f
  :iab <buffer> ov3 osg::Vec3i
  :iab <buffer> ov3 osg::Vec3s
  :iab <buffer> ov3 osg::Vec3ub
  :iab <buffer> ov3 osg::Vec3ui
  :iab <buffer> ov3 osg::Vec3us
  :iab <buffer> ov4 osg::Vec4b
  :iab <buffer> ov4 osg::Vec4d
  :iab <buffer> ov4 osg::Vec4f
  :iab <buffer> ov4 osg::Vec4i
  :iab <buffer> ov4 osg::Vec4s
  :iab <buffer> ov4 osg::Vec4ub
  :iab <buffer> ov4 osg::Vec4ui
  :iab <buffer> ov4 osg::Vec4us
  :iab <buffer> ovas osg::VertexArrayState
  :iab <buffer> ovasl osg::VertexArrayStateList
  :iab <buffer> ovad osg::VertexAttribDivisor
  :iab <buffer> ovp osg::VertexProgram
  :iab <buffer> ov osg::View
  :iab <buffer> ov osg::Viewport
  :iab <buffer> ovi osg::ViewportIndexed
  :iab <buffer> oaa osgAnimation::Action
  :iab <buffer> oaaa osgAnimation::ActionAnimation
  :iab <buffer> oaabi osgAnimation::ActionBlendIn
  :iab <buffer> oaabo osgAnimation::ActionBlendOut
  :iab <buffer> oara osgAnimation::RunAction
  :iab <buffer> oaasa osgAnimation::ActionStripAnimation
  :iab <buffer> oaav osgAnimation::ActionVisitor
  :iab <buffer> oauav osgAnimation::UpdateActionVisitor
  :iab <buffer> oacav osgAnimation::ClearActionVisitor
  :iab <buffer> oaa osgAnimation::Animation
  :iab <buffer> oaamb osgAnimation::AnimationManagerBase
  :iab <buffer> oaaucb osgAnimation::AnimationUpdateCallbackBase
  :iab <buffer> oaauc osgAnimation::AnimationUpdateCallback
  :iab <buffer> oabam osgAnimation::BasicAnimationManager
  :iab <buffer> oab osgAnimation::Bone
  :iab <buffer> oabmv osgAnimation::BoneMapVisitor
  :iab <buffer> oac osgAnimation::Channel
  :iab <buffer> oatc osgAnimation::TemplateChannel
  :iab <buffer> oatcb osgAnimation::TemplateCubicBezier
  :iab <buffer> oaobf osgAnimation::OutBounceFunction
  :iab <buffer> oaibf osgAnimation::InBounceFunction
  :iab <buffer> oaiobf osgAnimation::InOutBounceFunction
  :iab <buffer> oalf osgAnimation::LinearFunction
  :iab <buffer> oaoqf osgAnimation::OutQuadFunction
  :iab <buffer> oaiqf osgAnimation::InQuadFunction
  :iab <buffer> oaioqf osgAnimation::InOutQuadFunction
  :iab <buffer> oaocf osgAnimation::OutCubicFunction
  :iab <buffer> oaicf osgAnimation::InCubicFunction
  :iab <buffer> oaiocf osgAnimation::InOutCubicFunction
  :iab <buffer> oaiqf osgAnimation::InQuartFunction
  :iab <buffer> oaoqf osgAnimation::OutQuartFunction
  :iab <buffer> oaioqf osgAnimation::InOutQuartFunction
  :iab <buffer> oaoef osgAnimation::OutElasticFunction
  :iab <buffer> oaief osgAnimation::InElasticFunction
  :iab <buffer> oaioef osgAnimation::InOutElasticFunction
  :iab <buffer> oaosf osgAnimation::OutSineFunction
  :iab <buffer> oaisf osgAnimation::InSineFunction
  :iab <buffer> oaiosf osgAnimation::InOutSineFunction
  :iab <buffer> oaobf osgAnimation::OutBackFunction
  :iab <buffer> oaibf osgAnimation::InBackFunction
  :iab <buffer> oaiobf osgAnimation::InOutBackFunction
  :iab <buffer> oaocf osgAnimation::OutCircFunction
  :iab <buffer> oaicf osgAnimation::InCircFunction
  :iab <buffer> oaiocf osgAnimation::InOutCircFunction
  :iab <buffer> oaoef osgAnimation::OutExpoFunction
  :iab <buffer> oaief osgAnimation::InExpoFunction
  :iab <buffer> oaioef osgAnimation::InOutExpoFunction
  :iab <buffer> oam osgAnimation::Motion
  :iab <buffer> oammt osgAnimation::MathMotionTemplate
  :iab <buffer> oasmt osgAnimation::SamplerMotionTemplate
  :iab <buffer> oacm osgAnimation::CompositeMotion
  :iab <buffer> oatib osgAnimation::TemplateInterpolatorBase
  :iab <buffer> oatsi osgAnimation::TemplateStepInterpolator
  :iab <buffer> oatli osgAnimation::TemplateLinearInterpolator
  :iab <buffer> oatsli osgAnimation::TemplateSphericalLinearInterpolator
  :iab <buffer> oatlpi osgAnimation::TemplateLinearPackedInterpolator
  :iab <buffer> oatcbi osgAnimation::TemplateCubicBezierInterpolator
  :iab <buffer> oak osgAnimation::Keyframe
  :iab <buffer> oatk osgAnimation::TemplateKeyframe
  :iab <buffer> oakc osgAnimation::KeyframeContainer
  :iab <buffer> oatkc osgAnimation::TemplateKeyframeContainer
  :iab <buffer> oatkc osgAnimation::TemplateKeyframeContainer
  :iab <buffer> oalv osgAnimation::LinkVisitor
  :iab <buffer> oamg osgAnimation::MorphGeometry
  :iab <buffer> oaum osgAnimation::UpdateMorph
  :iab <buffer> oaumg osgAnimation::UpdateMorphGeometry
  :iab <buffer> oamth osgAnimation::MorphTransformHardware
  :iab <buffer> oamts osgAnimation::MorphTransformSoftware
  :iab <buffer> oarcbbc osgAnimation::RigComputeBoundingBoxCallback
  :iab <buffer> oarg osgAnimation::RigGeometry
  :iab <buffer> oaurg osgAnimation::UpdateRigGeometry
  :iab <buffer> oart osgAnimation::RigTransform
  :iab <buffer> oamt osgAnimation::MorphTransform
  :iab <buffer> oarth osgAnimation::RigTransformHardware
  :iab <buffer> oarts osgAnimation::RigTransformSoftware
  :iab <buffer> oas osgAnimation::Sampler
  :iab <buffer> oats osgAnimation::TemplateSampler
  :iab <buffer> oatcs osgAnimation::TemplateCompositeSampler
  :iab <buffer> oas osgAnimation::Skeleton
  :iab <buffer> oasme osgAnimation::StackedMatrixElement
  :iab <buffer> oasqe osgAnimation::StackedQuaternionElement
  :iab <buffer> oasrae osgAnimation::StackedRotateAxisElement
  :iab <buffer> oasse osgAnimation::StackedScaleElement
  :iab <buffer> oast osgAnimation::StackedTransform
  :iab <buffer> oaste osgAnimation::StackedTransformElement
  :iab <buffer> oaste osgAnimation::StackedTranslateElement
  :iab <buffer> oash osgAnimation::StatsHandler
  :iab <buffer> oasav osgAnimation::StatsActionVisitor
  :iab <buffer> oat osgAnimation::Target
  :iab <buffer> oatt osgAnimation::TemplateTarget
  :iab <buffer> oat osgAnimation::Timeline
  :iab <buffer> oatam osgAnimation::TimelineAnimationManager
  :iab <buffer> oaub osgAnimation::UpdateBone
  :iab <buffer> oaum osgAnimation::UpdateMaterial
  :iab <buffer> oaumt osgAnimation::UpdateMatrixTransform
  :iab <buffer> oauu osgAnimation::UpdateUniform
  :iab <buffer> oaufu osgAnimation::UpdateFloatUniform
  :iab <buffer> oauv2u osgAnimation::UpdateVec2fUniform
  :iab <buffer> oauv3u osgAnimation::UpdateVec3fUniform
  :iab <buffer> oauv4u osgAnimation::UpdateVec4fUniform
  :iab <buffer> oaumu osgAnimation::UpdateMatrixfUniform
  :iab <buffer> oav3p osgAnimation::Vec3Packed
  :iab <buffer> oav3ap osgAnimation::Vec3ArrayPacked
  :iab <buffer> oavi osgAnimation::VertexInfluence
  :iab <buffer> oavim osgAnimation::VertexInfluenceMap
  :iab <buffer> odba osgDB::Archive
  :iab <buffer> odbad osgDB::AuthenticationDetails
  :iab <buffer> odbam osgDB::AuthenticationMap
  :iab <buffer> odbffc osgDB::FindFileCallback
  :iab <buffer> odbrfc osgDB::ReadFileCallback
  :iab <buffer> odbwfc osgDB::WriteFileCallback
  :iab <buffer> odbflc osgDB::FileLocationCallback
  :iab <buffer> odbci osgDB::ClassInterface
  :iab <buffer> odb__30110308 osgDB::__anon30a1bda10308
  :iab <buffer> odb__30110408 osgDB::__anon30a1bda10408
  :iab <buffer> odbb64 osgDB::Base64encoder
  :iab <buffer> odbb64 osgDB::Base64decoder
  :iab <buffer> odbdp osgDB::DatabasePager
  :iab <buffer> odbfl osgDB::FileList
  :iab <buffer> odbdr osgDB::DatabaseRevision
  :iab <buffer> odbdr osgDB::DatabaseRevisions
  :iab <buffer> odbogl osgDB::ObjectGLenum
  :iab <buffer> odbop osgDB::ObjectProperty
  :iab <buffer> odbom osgDB::ObjectMark
  :iab <buffer> odbdow osgDB::DotOsgWrapper
  :iab <buffer> odbddowm osgDB::DeprecatedDotOsgWrapperManager
  :iab <buffer> odbrdowp osgDB::RegisterDotOsgWrapperProxy
  :iab <buffer> odbtrdowp osgDB::TemplateRegisterDotOsgWrapperProxy
  :iab <buffer> odbdl osgDB::DynamicLibrary
  :iab <buffer> odbefw osgDB::ExternalFileWriter
  :iab <buffer> odbfc osgDB::FileCache
  :iab <buffer> odbfnc osgDB::FileNameComparator
  :iab <buffer> odb osgDB::ifstream
  :iab <buffer> odb osgDB::ofstream
  :iab <buffer> odbio osgDB::ImageOptions
  :iab <buffer> odbip osgDB::ImagePager
  :iab <buffer> odbip osgDB::ImageProcessor
  :iab <buffer> odb__ osgDB::basic_type_wrapper
  :iab <buffer> odb_ osgDB::type_wrapper
  :iab <buffer> odbf osgDB::Field
  :iab <buffer> odbfr osgDB::FieldReader
  :iab <buffer> odbfri osgDB::FieldReaderIterator
  :iab <buffer> odbi osgDB::Input
  :iab <buffer> odbie osgDB::InputException
  :iab <buffer> odbis osgDB::InputStream
  :iab <buffer> odboc osgDB::ObjectCache
  :iab <buffer> odbmo osgDB::MethodObject
  :iab <buffer> odbbc osgDB::BaseCompressor
  :iab <buffer> odbforc osgDB::FinishedObjectReadCallback
  :iab <buffer> odbowa osgDB::ObjectWrapperAssociate
  :iab <buffer> odbow osgDB::ObjectWrapper
  :iab <buffer> odbuwvp osgDB::UpdateWrapperVersionProxy
  :iab <buffer> odbowm osgDB::ObjectWrapperManager
  :iab <buffer> odbrwp osgDB::RegisterWrapperProxy
  :iab <buffer> odbrcwp osgDB::RegisterCustomWrapperProxy
  :iab <buffer> odbrcp osgDB::RegisterCompressorProxy
  :iab <buffer> odbo osgDB::Options
  :iab <buffer> odbo osgDB::Output
  :iab <buffer> odboe osgDB::OutputException
  :iab <buffer> odbos osgDB::OutputStream
  :iab <buffer> odbpo osgDB::ParameterOutput
  :iab <buffer> odbrwi osgDB::ReaderWriterInfo
  :iab <buffer> odbrw osgDB::ReaderWriter
  :iab <buffer> odbr osgDB::Registry
  :iab <buffer> odbrrwp osgDB::RegisterReaderWriterProxy
  :iab <buffer> odbripp osgDB::RegisterImageProcessorProxy
  :iab <buffer> odbpfp osgDB::PluginFunctionProxy
  :iab <buffer> odbil osgDB::IntLookup
  :iab <buffer> odbultp osgDB::UserLookupTableProxy
  :iab <buffer> odbbs osgDB::BaseSerializer
  :iab <buffer> odbus osgDB::UserSerializer
  :iab <buffer> odbts osgDB::TemplateSerializer
  :iab <buffer> odbpbvs osgDB::PropByValSerializer
  :iab <buffer> odbpbrs osgDB::PropByRefSerializer
  :iab <buffer> odbms osgDB::MatrixSerializer
  :iab <buffer> odbgls osgDB::GLenumSerializer
  :iab <buffer> odbss osgDB::StringSerializer
  :iab <buffer> odbos osgDB::ObjectSerializer
  :iab <buffer> odbis osgDB::ImageSerializer
  :iab <buffer> odbes osgDB::EnumSerializer
  :iab <buffer> odbls osgDB::ListSerializer
  :iab <buffer> odbvbs osgDB::VectorBaseSerializer
  :iab <buffer> odbvs osgDB::VectorSerializer
  :iab <buffer> odbiavs osgDB::IsAVectorSerializer
  :iab <buffer> odbmio osgDB::MapIteratorObject
  :iab <buffer> odbmbs osgDB::MapBaseSerializer
  :iab <buffer> odbms osgDB::MapSerializer
  :iab <buffer> odbbfs osgDB::BitFlagsSerializer
  :iab <buffer> odbssm osgDB::SharedStateManager
  :iab <buffer> odboi osgDB::OutputIterator
  :iab <buffer> odbii osgDB::InputIterator
  :iab <buffer> odbxn osgDB::XmlNode
  :iab <buffer> ofxal osgFX::AnisotropicLighting
  :iab <buffer> ofxbm osgFX::BumpMapping
  :iab <buffer> ofxc osgFX::Cartoon
  :iab <buffer> ofxe osgFX::Effect
  :iab <buffer> ofxmtc osgFX::MultiTextureControl
  :iab <buffer> ofxo osgFX::Outline
  :iab <buffer> ofxr osgFX::Registry
  :iab <buffer> ofxs osgFX::Scribe
  :iab <buffer> ofxsh osgFX::SpecularHighlights
  :iab <buffer> ofxt osgFX::Technique
  :iab <buffer> ofxv osgFX::Validator
  :iab <buffer> ogaapm osgGA::AnimationPathManipulator
  :iab <buffer> ogacm osgGA::CameraManipulator
  :iab <buffer> ogacvsm osgGA::CameraViewSwitchManipulator
  :iab <buffer> ogad osgGA::Device
  :iab <buffer> ogadm osgGA::DriveManipulator
  :iab <buffer> ogae osgGA::Event
  :iab <buffer> ogaeh osgGA::EventHandler
  :iab <buffer> ogaeq osgGA::EventQueue
  :iab <buffer> ogaev osgGA::EventVisitor
  :iab <buffer> ogafpm osgGA::FirstPersonManipulator
  :iab <buffer> ogafm osgGA::FlightManipulator
  :iab <buffer> ogaguiaa osgGA::GUIActionAdapter
  :iab <buffer> ogapd osgGA::PointerData
  :iab <buffer> ogaguiea osgGA::GUIEventAdapter
  :iab <buffer> ogaguieh osgGA::GUIEventHandler
  :iab <buffer> ogaksmm osgGA::KeySwitchMatrixManipulator
  :iab <buffer> ogamttm osgGA::MultiTouchTrackballManipulator
  :iab <buffer> ogantm osgGA::NodeTrackerManipulator
  :iab <buffer> ogaom osgGA::OrbitManipulator
  :iab <buffer> ogasm osgGA::SphericalManipulator
  :iab <buffer> ogasm osgGA::StandardManipulator
  :iab <buffer> ogassm osgGA::StateSetManipulator
  :iab <buffer> ogatm osgGA::TerrainManipulator
  :iab <buffer> ogatm osgGA::TrackballManipulator
  :iab <buffer> ogaufom osgGA::UFOManipulator
  :iab <buffer> ogaw osgGA::Widget
  :iab <buffer> omas osgManipulator::AntiSquish
  :iab <buffer> ommc osgManipulator::MotionCommand
  :iab <buffer> omtilc osgManipulator::TranslateInLineCommand
  :iab <buffer> omtipc osgManipulator::TranslateInPlaneCommand
  :iab <buffer> oms1dc osgManipulator::Scale1DCommand
  :iab <buffer> oms2dc osgManipulator::Scale2DCommand
  :iab <buffer> omsuc osgManipulator::ScaleUniformCommand
  :iab <buffer> omr3dc osgManipulator::Rotate3DCommand
  :iab <buffer> omcm osgManipulator::CommandManager
  :iab <buffer> omdc osgManipulator::DraggerCallback
  :iab <buffer> omc osgManipulator::Constraint
  :iab <buffer> omgc osgManipulator::GridConstraint
  :iab <buffer> omdtc osgManipulator::DraggerTransformCallback
  :iab <buffer> ompi osgManipulator::PointerInfo
  :iab <buffer> omd osgManipulator::Dragger
  :iab <buffer> omcd osgManipulator::CompositeDragger
  :iab <buffer> omp osgManipulator::Projector
  :iab <buffer> omlp osgManipulator::LineProjector
  :iab <buffer> ompp osgManipulator::PlaneProjector
  :iab <buffer> omsp osgManipulator::SphereProjector
  :iab <buffer> omspp osgManipulator::SpherePlaneProjector
  :iab <buffer> omcp osgManipulator::CylinderProjector
  :iab <buffer> omcpp osgManipulator::CylinderPlaneProjector
  :iab <buffer> omrcd osgManipulator::RotateCylinderDragger
  :iab <buffer> omrsd osgManipulator::RotateSphereDragger
  :iab <buffer> oms1dd osgManipulator::Scale1DDragger
  :iab <buffer> oms2dd osgManipulator::Scale2DDragger
  :iab <buffer> omsad osgManipulator::ScaleAxisDragger
  :iab <buffer> omtbd osgManipulator::TabBoxDragger
  :iab <buffer> omtbtd osgManipulator::TabBoxTrackballDragger
  :iab <buffer> omtpd osgManipulator::TabPlaneDragger
  :iab <buffer> omtptd osgManipulator::TabPlaneTrackballDragger
  :iab <buffer> omtd osgManipulator::TrackballDragger
  :iab <buffer> omt1dd osgManipulator::Translate1DDragger
  :iab <buffer> omt2dd osgManipulator::Translate2DDragger
  :iab <buffer> omtad osgManipulator::TranslateAxisDragger
  :iab <buffer> omtpd osgManipulator::TranslatePlaneDragger
  :iab <buffer> opao osgParticle::AccelOperator
  :iab <buffer> opaao osgParticle::AngularAccelOperator
  :iab <buffer> opado osgParticle::AngularDampingOperator
  :iab <buffer> opbo osgParticle::BounceOperator
  :iab <buffer> opbp osgParticle::BoxPlacer
  :iab <buffer> opcp osgParticle::CenteredPlacer
  :iab <buffer> opcp osgParticle::CompositePlacer
  :iab <buffer> opcps osgParticle::ConnectedParticleSystem
  :iab <buffer> opcrc osgParticle::ConstantRateCounter
  :iab <buffer> opc osgParticle::Counter
  :iab <buffer> opdo osgParticle::DampingOperator
  :iab <buffer> opdo osgParticle::DomainOperator
  :iab <buffer> ope osgParticle::Emitter
  :iab <buffer> opede osgParticle::ExplosionDebrisEffect
  :iab <buffer> opee osgParticle::ExplosionEffect
  :iab <buffer> opeo osgParticle::ExplosionOperator
  :iab <buffer> opfe osgParticle::FireEffect
  :iab <buffer> opffo osgParticle::FluidFrictionOperator
  :iab <buffer> opfp osgParticle::FluidProgram
  :iab <buffer> opfo osgParticle::ForceOperator
  :iab <buffer> opi osgParticle::Interpolator
  :iab <buffer> opli osgParticle::LinearInterpolator
  :iab <buffer> opme osgParticle::ModularEmitter
  :iab <buffer> opmp osgParticle::ModularProgram
  :iab <buffer> opmsp osgParticle::MultiSegmentPlacer
  :iab <buffer> opo osgParticle::Operator
  :iab <buffer> opoo osgParticle::OrbitOperator
  :iab <buffer> opp osgParticle::Particle
  :iab <buffer> oppe osgParticle::ParticleEffect
  :iab <buffer> oppp osgParticle::ParticleProcessor
  :iab <buffer> opps osgParticle::ParticleSystem
  :iab <buffer> oppsu osgParticle::ParticleSystemUpdater
  :iab <buffer> opp osgParticle::Placer
  :iab <buffer> oppp osgParticle::PointPlacer
  :iab <buffer> oppe osgParticle::PrecipitationEffect
  :iab <buffer> opp osgParticle::Program
  :iab <buffer> oprs osgParticle::RadialShooter
  :iab <buffer> oprrc osgParticle::RandomRateCounter
  :iab <buffer> op osgParticle::range
  :iab <buffer> opsp osgParticle::SectorPlacer
  :iab <buffer> opsp osgParticle::SegmentPlacer
  :iab <buffer> ops osgParticle::Shooter
  :iab <buffer> opso osgParticle::SinkOperator
  :iab <buffer> opse osgParticle::SmokeEffect
  :iab <buffer> opste osgParticle::SmokeTrailEffect
  :iab <buffer> opvrc osgParticle::VariableRateCounter
  :iab <buffer> opram osgPresentation::AnimationMaterial
  :iab <buffer> opramc osgPresentation::AnimationMaterialCallback
  :iab <buffer> oprcsc osgPresentation::CompileSlideCallback
  :iab <buffer> oprc osgPresentation::Cursor
  :iab <buffer> oprkeh osgPresentation::KeyEventHandler
  :iab <buffer> oprpeh osgPresentation::PickEventHandler
  :iab <buffer> oprpm osgPresentation::PropertyManager
  :iab <buffer> oprpr osgPresentation::PropertyReader
  :iab <buffer> oprpa osgPresentation::PropertyAnimation
  :iab <buffer> oprisuc osgPresentation::ImageSequenceUpdateCallback
  :iab <buffer> oprpec osgPresentation::PropertyEventCallback
  :iab <buffer> oprjd osgPresentation::JumpData
  :iab <buffer> oprhp osgPresentation::HomePosition
  :iab <buffer> oprkp osgPresentation::KeyPosition
  :iab <buffer> oprlc osgPresentation::LayerCallback
  :iab <buffer> oprla osgPresentation::LayerAttributes
  :iab <buffer> oprfpd osgPresentation::FilePathData
  :iab <buffer> opr_ osgPresentation::dereference_less
  :iab <buffer> oproo osgPresentation::ObjectOperator
  :iab <buffer> oprao osgPresentation::ActiveOperators
  :iab <buffer> oprseh osgPresentation::SlideEventHandler
  :iab <buffer> oprhudt osgPresentation::HUDTransform
  :iab <buffer> oprssc osgPresentation::SlideShowConstructor
  :iab <buffer> oprhuds osgPresentation::HUDSettings
  :iab <buffer> oprt osgPresentation::Timeout
  :iab <buffer> oscp osgShadow::ConvexPolyhedron
  :iab <buffer> osdsm osgShadow::DebugShadowMap
  :iab <buffer> oslspsma osgShadow::LightSpacePerspectiveShadowMapAlgorithm
  :iab <buffer> oslspsmdb osgShadow::LightSpacePerspectiveShadowMapDB
  :iab <buffer> oslspsmcb osgShadow::LightSpacePerspectiveShadowMapCB
  :iab <buffer> oslspsmvb osgShadow::LightSpacePerspectiveShadowMapVB
  :iab <buffer> osmcbsm osgShadow::MinimalCullBoundsShadowMap
  :iab <buffer> osmdbsm osgShadow::MinimalDrawBoundsShadowMap
  :iab <buffer> osmsm osgShadow::MinimalShadowMap
  :iab <buffer> ospssm osgShadow::ParallelSplitShadowMap
  :iab <buffer> ospsm osgShadow::ProjectionShadowMap
  :iab <buffer> osss osgShadow::ShadowedScene
  :iab <buffer> ossm osgShadow::ShadowMap
  :iab <buffer> osss osgShadow::ShadowSettings
  :iab <buffer> osst osgShadow::ShadowTechnique
  :iab <buffer> osst osgShadow::ShadowTexture
  :iab <buffer> osssm osgShadow::SoftShadowMap
  :iab <buffer> osssm osgShadow::StandardShadowMap
  :iab <buffer> osvdsm osgShadow::ViewDependentShadowMap
  :iab <buffer> osvdst osgShadow::ViewDependentShadowTechnique
  :iab <buffer> osisg osgSim::SequenceGroup
  :iab <buffer> osibs osgSim::BlinkSequence
  :iab <buffer> osicr osgSim::ColorRange
  :iab <buffer> osidoft osgSim::DOFTransform
  :iab <buffer> osies osgSim::ElevationSlice
  :iab <buffer> osigl osgSim::GeographicLocation
  :iab <buffer> osihat osgSim::HeightAboveTerrain
  :iab <buffer> osii osgSim::Impostor
  :iab <buffer> osiis osgSim::ImpostorSprite
  :iab <buffer> osiism osgSim::ImpostorSpriteManager
  :iab <buffer> osiiiv osgSim::InsertImpostorsVisitor
  :iab <buffer> osilp osgSim::LightPoint
  :iab <buffer> osilpn osgSim::LightPointNode
  :iab <buffer> osilps osgSim::LightPointSystem
  :iab <buffer> osidcrc osgSim::DatabaseCacheReadCallback
  :iab <buffer> osilos osgSim::LineOfSight
  :iab <buffer> osims osgSim::MultiSwitch
  :iab <buffer> osiord osgSim::ObjectRecordData
  :iab <buffer> osion osgSim::OverlayNode
  :iab <buffer> osisb osgSim::ScalarBar
  :iab <buffer> osistc osgSim::ScalarsToColors
  :iab <buffer> osis osgSim::Sector
  :iab <buffer> osiar osgSim::AzimRange
  :iab <buffer> osier osgSim::ElevationRange
  :iab <buffer> osias osgSim::AzimSector
  :iab <buffer> osies osgSim::ElevationSector
  :iab <buffer> osiaes osgSim::AzimElevationSector
  :iab <buffer> osics osgSim::ConeSector
  :iab <buffer> osids osgSim::DirectionalSector
  :iab <buffer> osisa osgSim::ShapeAttribute
  :iab <buffer> osisal osgSim::ShapeAttributeList
  :iab <buffer> osiss osgSim::SphereSegment
  :iab <buffer> osivg osgSim::VisibilityGroup
  :iab <buffer> otedmt osgTerrain::DisplacementMappingTechnique
  :iab <buffer> otesg osgTerrain::SharedGeometry
  :iab <buffer> otegp osgTerrain::GeometryPool
  :iab <buffer> otehfd osgTerrain::HeightFieldDrawable
  :iab <buffer> otegt osgTerrain::GeometryTechnique
  :iab <buffer> otel osgTerrain::Layer
  :iab <buffer> oteil osgTerrain::ImageLayer
  :iab <buffer> otecl osgTerrain::ContourLayer
  :iab <buffer> otehfl osgTerrain::HeightFieldLayer
  :iab <buffer> otepl osgTerrain::ProxyLayer
  :iab <buffer> otecl osgTerrain::CompositeLayer
  :iab <buffer> otesl osgTerrain::SwitchLayer
  :iab <buffer> otel osgTerrain::Locator
  :iab <buffer> otet osgTerrain::Terrain
  :iab <buffer> otetn osgTerrain::TerrainNeighbours
  :iab <buffer> otett osgTerrain::TerrainTechnique
  :iab <buffer> otetid osgTerrain::TileID
  :iab <buffer> otett osgTerrain::TerrainTile
  :iab <buffer> otewltlc osgTerrain::WhiteListTileLoadedCallback
  :iab <buffer> otevdo osgTerrain::ValidDataOperator
  :iab <buffer> otevr osgTerrain::ValidRange
  :iab <buffer> otendv osgTerrain::NoDataValue
  :iab <buffer> otft osgText::FadeText
  :iab <buffer> otf osgText::Font
  :iab <buffer> otg osgText::Glyph
  :iab <buffer> otgg osgText::GlyphGeometry
  :iab <buffer> otg3d osgText::Glyph3D
  :iab <buffer> otgt osgText::GlyphTexture
  :iab <buffer> otvui osgText::VectorUInt
  :iab <buffer> ots osgText::String
  :iab <buffer> otb osgText::Bevel
  :iab <buffer> ots osgText::Style
  :iab <buffer> ott osgText::Text
  :iab <buffer> ott3d osgText::Text3D
  :iab <buffer> ottb osgText::TextBase
  :iab <buffer> ouias osgUI::AlignmentSettings
  :iab <buffer> ouicc osgUI::CloseCallback
  :iab <buffer> ouihc osgUI::HandleCallback
  :iab <buffer> ouidc osgUI::DragCallback
  :iab <buffer> ouicp osgUI::ColorPalette
  :iab <buffer> ouii osgUI::Item
  :iab <buffer> ouicb osgUI::ComboBox
  :iab <buffer> ouid osgUI::Dialog
  :iab <buffer> ouifs osgUI::FrameSettings
  :iab <buffer> ouil osgUI::Label
  :iab <buffer> ouile osgUI::LineEdit
  :iab <buffer> ouip osgUI::Popup
  :iab <buffer> ouipb osgUI::PushButton
  :iab <buffer> ouis osgUI::Style
  :iab <buffer> ouit osgUI::Tab
  :iab <buffer> ouitw osgUI::TabWidget
  :iab <buffer> ouits osgUI::TextSettings
  :iab <buffer> ouiv osgUI::Validator
  :iab <buffer> ouiiv osgUI::IntValidator
  :iab <buffer> ouidv osgUI::DoubleValidator
  :iab <buffer> ouiw osgUI::Widget
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucv osgUtil::ConvertVec
  :iab <buffer> oucmg osgUtil::CubeMapGenerator
  :iab <buffer> oucv osgUtil::CullVisitor
  :iab <buffer> oudc osgUtil::DelaunayConstraint
  :iab <buffer> oudt osgUtil::DelaunayTriangulator
  :iab <buffer> oudrv osgUtil::DisplayRequirementsVisitor
  :iab <buffer> oudets osgUtil::DrawElementTypeSimplifier
  :iab <buffer> oudetsv osgUtil::DrawElementTypeSimplifierVisitor
  :iab <buffer> ou_ osgUtil::dereference_less
  :iab <buffer> ou_ osgUtil::dereference_clear
  :iab <buffer> ouec osgUtil::EdgeCollector
  :iab <buffer> ouglov osgUtil::GLObjectsVisitor
  :iab <buffer> ougloo osgUtil::GLObjectsOperation
  :iab <buffer> ouhwmg osgUtil::HalfWayMapGenerator
  :iab <buffer> ouhmg osgUtil::HighlightMapGenerator
  :iab <buffer> oustc osgUtil::StateToCompile
  :iab <buffer> ouico osgUtil::IncrementalCompileOperation
  :iab <buffer> oui osgUtil::Intersector
  :iab <buffer> ouig osgUtil::IntersectorGroup
  :iab <buffer> ouiv osgUtil::IntersectionVisitor
  :iab <buffer> oulsi osgUtil::LineSegmentIntersector
  :iab <buffer> ougc osgUtil::GeometryCollector
  :iab <buffer> ouimv osgUtil::IndexMeshVisitor
  :iab <buffer> ouvcv osgUtil::VertexCacheVisitor
  :iab <buffer> ouvcmv osgUtil::VertexCacheMissVisitor
  :iab <buffer> ouvaov osgUtil::VertexAccessOrderVisitor
  :iab <buffer> ousao osgUtil::SharedArrayOptimizer
  :iab <buffer> ouoaf osgUtil::OperationArrayFunctor
  :iab <buffer> ouaro osgUtil::AddRangeOperator
  :iab <buffer> oumro osgUtil::MultiplyRangeOperator
  :iab <buffer> oubov osgUtil::BaseOptimizerVisitor
  :iab <buffer> ouo osgUtil::Optimizer
  :iab <buffer> oupn osgUtil::PerlinNoise
  :iab <buffer> oupi osgUtil::PlaneIntersector
  :iab <buffer> oupi osgUtil::PolytopeIntersector
  :iab <buffer> oupsc osgUtil::PositionalStateContainer
  :iab <buffer> oupv osgUtil::PrintVisitor
  :iab <buffer> ouri osgUtil::RayIntersector
  :iab <buffer> ourmg osgUtil::ReflectionMapGenerator
  :iab <buffer> ourb osgUtil::RenderBin
  :iab <buffer> ourl osgUtil::RenderLeaf
  :iab <buffer> ours osgUtil::RenderStage
  :iab <buffer> ourpf osgUtil::ReversePrimitiveFunctor
  :iab <buffer> ousgb osgUtil::SceneGraphBuilder
  :iab <buffer> ousv osgUtil::SceneView
  :iab <buffer> ousgv osgUtil::ShaderGenVisitor
  :iab <buffer> ous osgUtil::Simplifier
  :iab <buffer> ousv osgUtil::SmoothingVisitor
  :iab <buffer> ouldsf osgUtil::LessDepthSortFunctor
  :iab <buffer> ousg osgUtil::StateGraph
  :iab <buffer> ous osgUtil::Statistics
  :iab <buffer> ousv osgUtil::StatsVisitor
  :iab <buffer> outsg osgUtil::TangentSpaceGenerator
  :iab <buffer> out osgUtil::Tessellator
  :iab <buffer> outaf osgUtil::TransformAttributeFunctor
  :iab <buffer> outc osgUtil::TransformCallback
  :iab <buffer> ouuv osgUtil::UpdateVisitor
  :iab <buffer> ovghx11 osgViewer::GraphicsHandleX11
  :iab <buffer> ovgwx11 osgViewer::GraphicsWindowX11
  :iab <buffer> ovpbx11 osgViewer::PixelBufferX11
  :iab <buffer> ovgwios osgViewer::GraphicsWindowIOS
  :iab <buffer> ovgwc osgViewer::GraphicsWindowCarbon
  :iab <buffer> ovghc osgViewer::GraphicsHandleCarbon
  :iab <buffer> ovpbc osgViewer::PixelBufferCarbon
  :iab <buffer> ovpbw32 osgViewer::PixelBufferWin32
  :iab <buffer> ovghw32 osgViewer::GraphicsHandleWin32
  :iab <buffer> ovgww32 osgViewer::GraphicsWindowWin32
  :iab <buffer> ovghc osgViewer::GraphicsHandleCocoa
  :iab <buffer> ovgwc osgViewer::GraphicsWindowCocoa
  :iab <buffer> ovpbc osgViewer::PixelBufferCocoa
  :iab <buffer> ovcv osgViewer::CompositeViewer
  :iab <buffer> ovsw osgViewer::SingleWindow
  :iab <buffer> ovsd osgViewer::SphericalDisplay
  :iab <buffer> ovpsd osgViewer::PanoramicSphericalDisplay
  :iab <buffer> ovaas osgViewer::AcrossAllScreens
  :iab <buffer> ovwwvd osgViewer::WoWVxDisplay
  :iab <buffer> ovss osgViewer::SingleScreen
  :iab <buffer> ovgw osgViewer::GraphicsWindow
  :iab <buffer> ovgwe osgViewer::GraphicsWindowEmbedded
  :iab <buffer> ovgwfp osgViewer::GraphicsWindowFunctionProxy
  :iab <buffer> ovk osgViewer::Keystone
  :iab <buffer> ovkh osgViewer::KeystoneHandler
  :iab <buffer> ovoglqs osgViewer::OpenGLQuerySupport
  :iab <buffer> ovr osgViewer::Renderer
  :iab <buffer> ovs osgViewer::Scene
  :iab <buffer> ovvc osgViewer::ViewConfig
  :iab <buffer> ovdps osgViewer::DepthPartitionSettings
  :iab <buffer> ovv osgViewer::View
  :iab <buffer> ovv osgViewer::Viewer
  :iab <buffer> ovvb osgViewer::ViewerBase
  :iab <buffer> ovhh osgViewer::HelpHandler
  :iab <buffer> ovsh osgViewer::StatsHandler
  :iab <buffer> ovwsh osgViewer::WindowSizeHandler
  :iab <buffer> ovth osgViewer::ThreadingHandler
  :iab <buffer> ovrcph osgViewer::RecordCameraPathHandler
  :iab <buffer> ovlodsh osgViewer::LODScaleHandler
  :iab <buffer> ovtstvbh osgViewer::ToggleSyncToVBlankHandler
  :iab <buffer> ovsch osgViewer::ScreenCaptureHandler
  :iab <buffer> oviih osgViewer::InteractiveImageHandler
  :iab <buffer> ovofft osgVolume::FixedFunctionTechnique
  :iab <buffer> ovoid osgVolume::ImageDetails
  :iab <buffer> ovol osgVolume::Layer
  :iab <buffer> ovoil osgVolume::ImageLayer
  :iab <buffer> ovocl osgVolume::CompositeLayer
  :iab <buffer> ovol osgVolume::Locator
  :iab <buffer> ovotlc osgVolume::TransformLocatorCallback
  :iab <buffer> ovotglc osgVolume::TexGenLocatorCallback
  :iab <buffer> ovomt osgVolume::MultipassTechnique
  :iab <buffer> ovopv osgVolume::PropertyVisitor
  :iab <buffer> ovop osgVolume::Property
  :iab <buffer> ovocp osgVolume::CompositeProperty
  :iab <buffer> ovosp osgVolume::SwitchProperty
  :iab <buffer> ovotfp osgVolume::TransferFunctionProperty
  :iab <buffer> ovosp osgVolume::ScalarProperty
  :iab <buffer> ovoisp osgVolume::IsoSurfaceProperty
  :iab <buffer> ovoafp osgVolume::AlphaFuncProperty
  :iab <buffer> ovomipp osgVolume::MaximumIntensityProjectionProperty
  :iab <buffer> ovolp osgVolume::LightingProperty
  :iab <buffer> ovosdp osgVolume::SampleDensityProperty
  :iab <buffer> ovosdwmp osgVolume::SampleDensityWhenMovingProperty
  :iab <buffer> ovosrp osgVolume::SampleRatioProperty
  :iab <buffer> ovosrwmp osgVolume::SampleRatioWhenMovingProperty
  :iab <buffer> ovotp osgVolume::TransparencyProperty
  :iab <buffer> ovoetfp osgVolume::ExteriorTransparencyFactorProperty
  :iab <buffer> ovocpv osgVolume::CollectPropertiesVisitor
  :iab <buffer> ovopac osgVolume::PropertyAdjustmentCallback
  :iab <buffer> ovortt osgVolume::RayTracedTechnique
  :iab <buffer> ovov osgVolume::Volume
  :iab <buffer> ovovs osgVolume::VolumeScene
  :iab <buffer> ovovs osgVolume::VolumeSettings
  :iab <buffer> ovotd osgVolume::TileData
  :iab <buffer> ovovt osgVolume::VolumeTechnique
  :iab <buffer> ovotid osgVolume::TileID
  :iab <buffer> ovovt osgVolume::VolumeTile
  :iab <buffer> owb osgWidget::Box
  :iab <buffer> owbm osgWidget::BrowserManager
  :iab <buffer> owbi osgWidget::BrowserImage
  :iab <buffer> owb osgWidget::Browser
  :iab <buffer> owc osgWidget::Canvas
  :iab <buffer> owe osgWidget::Event
  :iab <buffer> owci osgWidget::CallbackInterface
  :iab <buffer> owoc osgWidget::ObjectCallback
  :iab <buffer> owfc osgWidget::FunctionCallback
  :iab <buffer> owc osgWidget::Callback
  :iab <buffer> owei osgWidget::EventInterface
  :iab <buffer> owf osgWidget::Frame
  :iab <buffer> owi osgWidget::Input
  :iab <buffer> owl osgWidget::Label
  :iab <buffer> owle osgWidget::LuaEngine
  :iab <buffer> owgh osgWidget::GeometryHints
  :iab <buffer> owpi osgWidget::PdfImage
  :iab <buffer> owpr osgWidget::PdfReader
  :iab <buffer> owpe osgWidget::PythonEngine
  :iab <buffer> owse osgWidget::ScriptEngine
  :iab <buffer> owsi osgWidget::StyleInterface
  :iab <buffer> ows osgWidget::Style
  :iab <buffer> owsm osgWidget::StyleManager
  :iab <buffer> owt osgWidget::Table
  :iab <buffer> owuiop osgWidget::UIObjectParent
  :iab <buffer> owmh osgWidget::MouseHandler
  :iab <buffer> owkh osgWidget::KeyboardHandler
  :iab <buffer> owrh osgWidget::ResizeHandler
  :iab <buffer> owcsh osgWidget::CameraSwitchHandler
  :iab <buffer> owvi osgWidget::VncImage
  :iab <buffer> owvc osgWidget::VncClient
  :iab <buffer> oww osgWidget::Widget
  :iab <buffer> ownw osgWidget::NotifyWidget
  :iab <buffer> ownw osgWidget::NullWidget
  :iab <buffer> oww osgWidget::Window
  :iab <buffer> owwm osgWidget::WindowManager

  " manual
  :iab <buffer> oaa osgAnimation::Animation
  :iab <buffer> oadcbc osgAnimation::DoubleCubicBezierChannel
  :iab <buffer> oadlc osgAnimation::DoubleLinearChannel
  :iab <buffer> oadsc osgAnimation::DoubleStepChannel
  :iab <buffer> oafcbc osgAnimation::FloatCubicBezierChannel
  :iab <buffer> oaflc osgAnimation::FloatLinearChannel
  :iab <buffer> oafsc osgAnimation::FloatStepChannel
  :iab <buffer> oaibf osgAnimation::InBounceFunction
  :iab <buffer> oaibm osgAnimation::InBackMotion
  :iab <buffer> oaibm osgAnimation::InBounceMotion
  :iab <buffer> oaicm osgAnimation::InCircMotion
  :iab <buffer> oaicm osgAnimation::InCubicMotion
  :iab <buffer> oaief osgAnimation::InExpoFunction
  :iab <buffer> oaiem osgAnimation::InElasticMotion
  :iab <buffer> oaiem osgAnimation::InExpoMotion
  :iab <buffer> oaiobf osgAnimation::InOutBounceFunction
  :iab <buffer> oaiobm osgAnimation::InOutBackMotion
  :iab <buffer> oaiobm osgAnimation::InOutBounceMotion
  :iab <buffer> oaiocf osgAnimation::InOutCubicFunction
  :iab <buffer> oaiocm osgAnimation::InOutCircMotion
  :iab <buffer> oaiocm osgAnimation::InOutCubicMotion
  :iab <buffer> oaioef osgAnimation::InOutExpoFunction
  :iab <buffer> oaioem osgAnimation::InOutElasticMotion
  :iab <buffer> oaioem osgAnimation::InOutExpoMotion
  :iab <buffer> oaioqf osgAnimation::InOutQuartFunction
  :iab <buffer> oaioqm osgAnimation::InOutQuadMotion
  :iab <buffer> oaioqm osgAnimation::InOutQuartMotion
  :iab <buffer> oaiosm osgAnimation::InOutSineMotion
  :iab <buffer> oaiqm osgAnimation::InQuadMotion
  :iab <buffer> oaiqm osgAnimation::InQuartMotion
  :iab <buffer> oaism osgAnimation::InSineMotion
  :iab <buffer> oamlc osgAnimation::MatrixLinearChannel
  :iab <buffer> oaobm osgAnimation::OutBackMotion
  :iab <buffer> oaobm osgAnimation::OutBounceMotion
  :iab <buffer> oaocm osgAnimation::OutCircMotion
  :iab <buffer> oaocm osgAnimation::OutCubicMotion
  :iab <buffer> oaoef osgAnimation::OutExpoFunction
  :iab <buffer> oaoem osgAnimation::OutElasticMotion
  :iab <buffer> oaoem osgAnimation::OutExpoMotion
  :iab <buffer> oaoqf osgAnimation::OutQuartFunction
  :iab <buffer> oaoqm osgAnimation::OutQuadMotion
  :iab <buffer> oaoqm osgAnimation::OutQuartMotion
  :iab <buffer> oaosm osgAnimation::OutSineMotion
  :iab <buffer> oap osg::AnimationPath
  :iab <buffer> oap osg::ArgumentParser
  :iab <buffer> oaqsc osgAnimation::QuatStepChannel
  :iab <buffer> oaqslc osgAnimation::QuatSphericalLinearChannel
  :iab <buffer> oas osg::AudioStream
  :iab <buffer> oaste osgAnimation::StackedTranslateElement
  :iab <buffer> oat osg::AutoTransform
  :iab <buffer> oav2cbc osgAnimation::Vec2CubicBezierChannel
  :iab <buffer> oav2lc osgAnimation::Vec2LinearChannel
  :iab <buffer> oav2sc osgAnimation::Vec2StepChannel
  :iab <buffer> oav3cbc osgAnimation::Vec3CubicBezierChannel
  :iab <buffer> oav3lc osgAnimation::Vec3LinearChannel
  :iab <buffer> oav3sc osgAnimation::Vec3StepChannel
  :iab <buffer> oav4cbc osgAnimation::Vec4CubicBezierChannel
  :iab <buffer> oav4lc osgAnimation::Vec4LinearChannel
  :iab <buffer> oav4sc osgAnimation::Vec4StepChannel
  :iab <buffer> obb osg::BoundingBox
  :iab <buffer> obe osg::BlendEquationi
  :iab <buffer> obf osg::BlendFunc
  :iab <buffer> obo osg::BufferObject
  :iab <buffer> obd osg::Billboard
  :iab <buffer> ob osg::Box
  :iab <buffer> obs osg::BoundingSphere
  :iab <buffer> occ osg::ClipControl
  :iab <buffer> ocm osg::ColorMatrix
  :iab <buffer> ocn osg::ClipNode
  :iab <buffer> oco osg::CopyOp
  :iab <buffer> oc osg::Camera
  :iab <buffer> ocs osg::CullSettings
  :iab <buffer> odbb64 osgDB::Base64encoder
  :iab <buffer> odbdr osgDB::DatabaseRevisions
  :iab <buffer> odbip osgDB::ImageProcessor
  :iab <buffer> odbis osgDB::InputStream
  :iab <buffer> odbms osgDB::MatrixSerializer
  :iab <buffer> odbo osgDB::Output
  :iab <buffer> odb osgDB::
  :iab <buffer> odbos osgDB::OutputStream
  :iab <buffer> od osg::Drawable
  :iab <buffer> oet osgPresentation::Timeout
  :iab <buffer> ogce osg::GraphicsCostEstimator
  :iab <buffer> ogsm osgGA::StandardManipulator
  :iab <buffer> ogtm osgGA::TrackballManipulator
  :iab <buffer> oies osgSim::ElevationSlice
  :iab <buffer> ois osgSim::Sector
  :iab <buffer> ols osg::LineSegment
  :iab <buffer> om osg::Matrix
  :iab <buffer> omt osg::MatrixTransform
  :iab <buffer> omtpd osgManipulator::TranslatePlaneDragger
  :iab <buffer> ool osgVolume::Layer
  :iab <buffer> oo osg::Object
  :iab <buffer> o_ osg::ref_ptr
  :iab <buffer> oovs osgVolume::VolumeSettings
  :iab <buffer> oovt osgVolume::VolumeTile
  :iab <buffer> opbo osg::PixelBufferObject
  :iab <buffer> opcp osgParticle::CompositePlacer
  :iab <buffer> opdo osgParticle::DomainOperator
  :iab <buffer> opo osg::PolygonOffset
  :iab <buffer> op osg::Program
  :iab <buffer> oppe osgParticle::PrecipitationEffect
  :iab <buffer> oppp osgParticle::PointPlacer
  :iab <buffer> ops osg::PointSprite
  :iab <buffer> orb osg::RenderBuffer
  :iab <buffer> orcl osgTerrain::ContourLayer
  :iab <buffer> orl osgTerrain::Locator
  :iab <buffer> orm osg::RefMatrixf
  :iab <buffer> ortt osgTerrain::TerrainTile
  :iab <buffer> osa osg::StateAttribute
  :iab <buffer> osc osg::ShaderComposer
  :iab <buffer> osm osg::ShadeModel
  :iab <buffer> os osg::Shader
  :iab <buffer> osssm osgShadow::StandardShadowMap
  :iab <buffer> osss osgShadow::ShadowSettings
  :iab <buffer> osst osgShadow::ShadowTexture
  :iab <buffer> otb osg::TextureBuffer
  :iab <buffer> otf osg::TriangleFunctor
  :iab <buffer> otg osg::TexGen
  :iab <buffer> otm osg::TexMat
  :iab <buffer> ot osg::Texture
  :iab <buffer> otr osg::TextureRectangle
  :iab <buffer> oucv osgUtil::CullVisitor
  :iab <buffer> oudc osgUtil::DelaunayConstraint
  :iab <buffer> ouiv osgUtil::IntersectVisitor
  :iab <buffer> oupi osgUtil::PolytopeIntersector
  :iab <buffer> oupv osgUtil::PrintVisitor
  :iab <buffer> ous osgUtil::Statistics
  :iab <buffer> ous osgUtil::Statistics
  :iab <buffer> ousv osgUtil::StatsVisitor
  :iab <buffer> ov2a osg::Vec2Array
  :iab <buffer> ov2 osg::Vec2
  :iab <buffer> ov3a osg::Vec3Array
  :iab <buffer> ov4a osg::Vec4Array
  :iab <buffer> ov osg::Viewport
  :iab <buffer> ovv osgViewer::Viewer
  :iab <buffer> owb osgWidget::Browser
  :iab <buffer> owc osgWidget::Canvas
  :iab <buffer> ownw osgWidget::NullWidget
  :iab <buffer> oww osgWidget::Window
  :iab <buffer> oge osg::Geode
  :iab <buffer> ov2 osg::Vec2
  :iab <buffer> ov3 osg::Vec3
  :iab <buffer> ov4 osg::Vec4
  :iab <buffer> ogm osg::Geometry
  :iab <buffer> oma osg::Material
endfunction

function abbre#ogre()
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
  :iab <buffer> Oop Ogre::Particle
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
  " :iab <buffer> Oeso Ogre::ShadeOptions
  :iab <buffer> Oeso Ogre::StencilOperation
  :iab <buffer> Oest Ogre::ShaderType
  :iab <buffer> Oetfo Ogre::TextureFilterOptions
  :iab <buffer> Oetvc Ogre::TrackVertexColourEnum
  :iab <buffer> Oevp Ogre::VertexPass
  :iab <buffer> Oewt Ogre::WaveformType
  :iab <buffer> Oellt Ogre::Light::LightTypes
  :iab <buffer> Oents Ogre::Node::TransformSpace
endfunction

function abbre#qt()
endfunction

" a little helper to comment duplicated abbrevation
function abbre#clearDuplicatedAbbrevation() abort
  while 1
    normal! j
    if line('.') == line('$')
      break
    endif

    let l0 = getline('.')
    if misc#isVimComment(l0) | continue | endif
    let abbre0 = matchstr(l0, '\v\<buffer\>\s+\zs\w+')
    if abbre0 ==# '' | continue | endif

    let l1 = getline(line('.')+1)
    if misc#isComment(l1) | continue | endif
    let abbre1 = matchstr(l1, '\v\<buffer\>\s+\zs\w+')
    if abbre1 ==# '' | continue | endif
    if abbre0 ==# abbre1
      exec 'normal! I" '
    endif

  endwhile
endfunction
