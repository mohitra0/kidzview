import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/resize.dart';
import 'dart:async';

class LiveStreamingPage extends StatefulWidget {
  const LiveStreamingPage({super.key});

  @override
  State<LiveStreamingPage> createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  final Resize resize = Resize();
  
  // Sample YouTube video IDs for demo
  final List<Map<String, dynamic>> cameras = [
    {
      'id': 1,
      'name': 'Classroom A - Toddlers',
      'location': 'Ground Floor',
      'videoId': 'jfKfPfyJRdk', // Sample YouTube video ID
      'viewers': 24,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/jfKfPfyJRdk/maxresdefault.jpg',
    },
    {
      'id': 2,
      'name': 'Classroom B - Pre-K',
      'location': 'First Floor',
      'videoId': 'ysz5S6PUM-U', // Sample YouTube video ID
      'viewers': 18,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/ysz5S6PUM-U/maxresdefault.jpg',
    },
    {
      'id': 3,
      'name': 'Classroom C - Nursery',
      'location': 'Ground Floor',
      'videoId': 'jfKfPfyJRdk',
      'viewers': 31,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/jfKfPfyJRdk/maxresdefault.jpg',
    },
    {
      'id': 4,
      'name': 'Classroom D - Kindergarten',
      'location': 'Second Floor',
      'videoId': 'ysz5S6PUM-U',
      'viewers': 22,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/ysz5S6PUM-U/maxresdefault.jpg',
    },
    {
      'id': 5,
      'name': 'Play Area - Outdoor',
      'location': 'Garden',
      'videoId': 'jfKfPfyJRdk',
      'viewers': 45,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/jfKfPfyJRdk/maxresdefault.jpg',
    },
    {
      'id': 6,
      'name': 'Activity Room',
      'location': 'First Floor',
      'videoId': 'ysz5S6PUM-U',
      'viewers': 15,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/ysz5S6PUM-U/maxresdefault.jpg',
    },
    {
      'id': 7,
      'name': 'Cafeteria',
      'location': 'Ground Floor',
      'videoId': 'jfKfPfyJRdk',
      'viewers': 28,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/jfKfPfyJRdk/maxresdefault.jpg',
    },
    {
      'id': 8,
      'name': 'Main Entrance',
      'location': 'Reception',
      'videoId': 'ysz5S6PUM-U',
      'viewers': 12,
      'isOnline': true,
      'thumbnail': 'https://img.youtube.com/vi/ysz5S6PUM-U/maxresdefault.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(resize.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: resize.height * 0.025),
          _buildCameraGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1f2937), Color(0xFF111827)],
        ),
        borderRadius: BorderRadius.circular(resize.width * 0.01),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resize.width * 0.012),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            child: Icon(
              Icons.videocam,
              color: Colors.white,
              size: resize.iconSize * 2,
            ),
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Camera Feeds',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading2,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  '${cameras.length} cameras online • ${cameras.fold<int>(0, (sum, cam) => sum + (cam['viewers'] as int))} total viewers',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: resize.width * 0.015,
              vertical: resize.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF10b981),
              borderRadius: BorderRadius.circular(resize.width * 0.006),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: resize.width * 0.008,
                  height: resize.width * 0.008,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: resize.width * 0.006),
                Text(
                  'All Systems Online',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: resize.width * 0.015,
        mainAxisSpacing: resize.height * 0.02,
        childAspectRatio: 1.4,
      ),
      itemCount: cameras.length,
      itemBuilder: (context, index) {
        return _buildCameraCard(cameras[index]);
      },
    );
  }

  Widget _buildCameraCard(Map<String, dynamic> camera) {
    return InkWell(
      onTap: () => _openCameraStream(camera),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(resize.width * 0.01),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(resize.width * 0.01),
                      topRight: Radius.circular(resize.width * 0.01),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF1f2937),
                      child: Image.network(
                        camera['thumbnail'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.videocam,
                              size: resize.iconSize * 3,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Live Badge
                  Positioned(
                    top: resize.height * 0.012,
                    left: resize.width * 0.01,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.008,
                        vertical: resize.height * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(resize.width * 0.004),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: resize.width * 0.006,
                            height: resize.width * 0.006,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: resize.width * 0.004),
                          Text(
                            'LIVE',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Viewer Count
                  Positioned(
                    top: resize.height * 0.012,
                    right: resize.width * 0.01,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.008,
                        vertical: resize.height * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(resize.width * 0.004),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility,
                            size: resize.lableText,
                            color: Colors.white,
                          ),
                          SizedBox(width: resize.width * 0.003),
                          Text(
                            '${camera['viewers']}',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.lableText,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Play Overlay
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(resize.width * 0.012),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: resize.iconSize * 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Camera Info
            Padding(
              padding: EdgeInsets.all(resize.width * 0.012),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camera['name'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizebase,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1f2937),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: resize.height * 0.004),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: resize.lableText,
                        color: const Color(0xFF6b7280),
                      ),
                      SizedBox(width: resize.width * 0.003),
                      Expanded(
                        child: Text(
                          camera['location'],
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.lableText,
                            color: const Color(0xFF6b7280),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: resize.width * 0.006,
                        height: resize.width * 0.006,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10b981),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCameraStream(Map<String, dynamic> camera) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoId: camera['videoId'],
          cameraName: camera['name'],
          location: camera['location'],
          viewers: camera['viewers'],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String cameraName;
  final String location;
  final int viewers;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.cameraName,
    required this.location,
    required this.viewers,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final Resize resize = Resize();
  bool _isPlaying = true;
  bool _isMuted = false;
  Timer? _timer;
  int _viewerCount = 0;

  @override
  void initState() {
    super.initState();
    _viewerCount = widget.viewers;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
    });
    
    // Simulate viewer count fluctuation
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _viewerCount = widget.viewers + (timer.tick % 5) - 2;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Player Area
          Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: const Color(0xFF1f2937),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Thumbnail/Placeholder
                    Image.network(
                      'https://images.unsplash.com/photo-1587654780291-39c9404d746b?w=1920',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF1f2937),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.videocam,
                                  size: resize.iconSize * 5,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                SizedBox(height: resize.height * 0.02),
                                Text(
                                  'Live Stream',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: resize.heading2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                SizedBox(height: resize.height * 0.01),
                                Text(
                                  'Camera feed would appear here',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: resize.fontSizeSmall,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Play/Pause Overlay (center)
                    if (!_isPlaying)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(resize.width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              size: resize.iconSize * 4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    // Controls Overlay (bottom)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(resize.width * 0.015),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: resize.iconSize * 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                _isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                                size: resize.iconSize * 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isMuted = !_isMuted;
                                });
                              },
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: resize.width * 0.01,
                                vertical: resize.height * 0.006,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(resize.width * 0.004),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: resize.width * 0.008,
                                    height: resize.width * 0.008,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFEF4444),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: resize.width * 0.006),
                                  Text(
                                    'LIVE',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: resize.fontSizeSmall,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: resize.width * 0.01),
                            IconButton(
                              icon: Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: resize.iconSize * 1.5,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(resize.width * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: resize.iconSize * 1.5,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: resize.width * 0.01),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cameraName,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.heading4,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.location,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.fontSizeSmall,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: resize.width * 0.008,
                            height: resize.width * 0.008,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: resize.width * 0.006),
                          Text(
                            'LIVE',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.fontSizeSmall,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: resize.width * 0.01),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: resize.width * 0.012,
                        vertical: resize.height * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility,
                            size: resize.fontSizeSmall,
                            color: Colors.white,
                          ),
                          SizedBox(width: resize.width * 0.004),
                          Text(
                            '$_viewerCount',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.fontSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

