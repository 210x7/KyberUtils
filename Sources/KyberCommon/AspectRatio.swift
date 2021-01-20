//
//  AspectRatio.swift
//  SturmfreiCommon
//
//  Created by Cristian Díaz on 30.09.20.
//

import CoreGraphics

/// The aspect ratio of an image is the ratio of its width to its height.
/// It is commonly expressed as two numbers separated by a colon, as in 16:9. For an x:y aspect ratio, the image is x units wide and y units high.
/// Widely used aspect ratios include 1.85:1 and 2.39:1 in film photography, 4:3 and 16:9 in television, and 3:2 in still camera photography.
///
/// https://en.wikipedia.org/wiki/Aspect_ratio_(image)

public enum AspectRatio  {
  
  /// 1.19:1 (19:16): Sometimes referred to as the Movietone ratio, this ratio was used briefly during the transitional period when the film industry was converting to sound, from 1926 to 1932 approx.
  /// It is produced by superimposing an optical soundtrack over a full-gate 1.3 aperture in printing, resulting in an almost square image.
  /// Films shot in this ratio are often projected or transferred to video incorrectly using a 1.37 mask or squashed to 1.37.
  /// Examples of films shot in the Movietone ratio include Sunrise, M, Hallelujah! and, significantly more recently, The Lighthouse.
  case movietone
  
  /// 1.25:1 (5:4): Once-popular aspect for larger format computer monitors, especially in the guise of mass-produced 17" and 19" LCD panels or 19" and 21" CRTs, using 1280×1024 (SXGA) or similar resolutions.
  /// Notably one of the few popular display aspect ratios narrower than 4:3, and one popularised by business (CAD, DTP) rather than entertainment use, as it is well-suited to full-page layout editing.
  /// Historically, 5:4 was also the original aspect ratio of early 405-line television broadcasts, which progressed to a wider 4:3 as the idea of broadcasting cinema films gained traction.
  case vintageMonitor
  
  /// 1.3:1 (4:3): 35 mm original silent film ratio, today commonly known in TV and video as 4:3.
  /// Also standard ratio for MPEG-2 video compression.
  /// This format is still used in many personal video cameras today and has influenced the selection or design of other aspect ratios.
  /// It is the standard Super 35mm ratio.
  case original35
  
  /// 1.37:1 (48:35): 16 mm and 35 mm standard ratio.
  case standard1635
  
  /// 1.375:1 (11:8): 35 mm full-screen sound film image, nearly universal in movies between 1932 and 1953.
  /// Officially adopted as the Academy ratio in 1932 by AMPAS.
  /// Rarely used in theatrical context nowadays, but occasionally used for other context.
  case fullscreen35
  
  /// 1.43:1: IMAX format. IMAX productions use 70 mm wide film (the same as used for 70 mm feature films), but the film runs through the camera and projector horizontally.
  /// This allows for a physically larger area for each image.
  case imax
  
  /// 1.5:1 (3:2): The aspect ratio of 35 mm film used for still photography when 8 perforations are exposed.
  /// Also the native aspect ratio of VistaVision, for which the film runs horizontally.
  /// Used on the Chrome OS-based Chromebook Pixel Notebook PC, the Game Boy Advance portable game console, the Surface Pro 3 laplet and Surface Studio.
  case vistavision
  
  /// 1.5:1 (14:9): Widescreen aspect ratio sometimes used in shooting commercials etc. as a compromise format between 4:3 and 16:9.
  /// When converted to a 16:9 frame, there is slight pillarboxing, while conversion to 4:3 creates slight letterboxing.
  /// All widescreen content on ABC Family's SD feed until January 2016 were presented in this ratio.
  case widescreen
  
  /// 1.6:1 (16:10 = 8:5): Widescreen computer monitor ratio (for instance 1920×1200 resolution).
  case widescreenMonitor

  /// 1.6:1 (5:3): 35 mm widescreen ratio, originally invented by Paramount Pictures, now a standard among several European countries.[which?]
  /// It is also the native Super 16 mm frame ratio. Sometimes this ratio is rounded up to 1.67:1.
  /// From the late 1980s to the early 2000s, Walt Disney Feature Animation's CAPS program animated their features in the 1.6:1 ratio (a compromise between the 1.85:1 theatrical ratio and the 1.3:1 ratio used for home video),
  /// this format is also used on the Nintendo 3DS's top screen as well.
  case super16
    
  /// 1.75:1 (7:4): Early 35 mm widescreen ratio, primarily used by MGM and Warner Bros. between 1953 and 1955, and since abandoned,
  /// though Disney has cropped some of its post-1950s full screen films to this ratio for DVD, including The Jungle Book.
  case earlyWidescreen
  
  /// 1.7:1 (16:9 = 42:32): Video widescreen standard, used in high-definition television, one of three ratios specified for MPEG-2 video compression.
  /// Also used increasingly in personal video cameras. Sometimes this ratio is rounded up to 1.78:1.
  case videoWidescreen
  
  /// 1.85:1 (37:20): 35 mm US and UK widescreen standard for theatrical film.
  /// Introduced by Universal Pictures in May, 1953.
  /// Projects approximately 3 perforations ("perfs") of image space per 4 perf frame; films can be shot in 3-perf to save cost of film stock.
  /// Also the ratio of Ultra 16 mm.
  case ultra16
  
  /// 1.896:1 (256:135): DCI / SMPTE digital cinema basic resolution container aspect ratio.
  case digitalCinemaBasic
  
  /// 2:1: Recently popularized by the Red Digital Cinema Camera Company.
  /// Original SuperScope ratio, also used in Univisium.
  /// Used as a flat ratio for some American studios in the 1950s and abandoned in the 1960s.
  /// Also used in recent mobile phones such as the LG G6, Google Pixel 2 XL, HTC U11+, Xiaomi MIX 2S and Huawei Mate 10 Pro,
  /// while the Samsung Galaxy S8, Note 8, and S9 use the similar 18.5:9 ratio.
  case superScope
  
  /// 2.165:1 (~28:13): iPhone X, Xs, Xs Max, 11, 11 Pro, 11 Pro Max
  case iPhoneX
  
  /// 2.2:1 (11:5): 70 mm standard.
  /// Originally developed for Todd-AO in the 1950s.
  /// Specified in MPEG-2 as 2.21:1, but hardly used.
  case standard70
  
  /// 2.35:1 (~47:20): 35 mm anamorphic prior to 1970, used by CinemaScope ("'Scope") and early Panavision.
  /// The anamorphic standard has subtly changed so that modern anamorphic productions are actually 2.39, but often referred to as 2.35 anyway, due to old convention.
  /// (Note that anamorphic refers to the compression of the image on film to maximize an area slightly taller than standard 4-perf Academy aperture, but presents the widest of aspect ratios.)
  /// All Indian Bollywood films released after 1972 are shot in this standard for theatrical exhibition.
  case cinemaScope
  
  /// 2.370:1 (64:27 = 43:33): TVs were produced with this aspect ratio between 2009 and 2012[26] and marketed as "21:9 cinema displays".
  /// But this aspect ratio is still seen on higher end monitors, and are sometimes called UltraWide monitors.
  case cinemaDisplay
  
  /// 2.39:1 (~43:18): 35 mm anamorphic from 1970 onwards.
  /// Aspect ratio of current anamorphic widescreen theatrical viewings, commercials, and some music videos.
  ///  Often commercially branded as Panavision format or 'Scope'.
  case panavision
  
  /// 2.4:1 (12:5): Rounded notation of 2.39:1, also as 2.40:1.
  /// Blu-ray Disc film releases may use only 800 instead of 803 or 804 lines of the 1920×1080 resolution, resulting in an even 2.4:1 aspect ratio.
  case bluray
  
  /// 2.55:1 (~23:9): Original aspect ratio of CinemaScope before optical sound was added to the film in 1954. This was also the aspect ratio of CinemaScope 55.
  case cinemaScope55
  
  /// 2.59:1 (~70:27): Cinerama at full height (three specially captured 35 mm images projected side-by-side into one composite widescreen image).
  case cinerama
  
  /// 2.6:1 (8:3): Full frame output from Super 16 mm negative when an anamorphic lens system has been used.
  /// Effectively, an image that is of the ratio 24:9 is squashed onto the native 15:9 aspect ratio of a Super 16 mm negative.
  case fullFrame
  
  /// 2.76:1 (~11:4): Ultra Panavision 70/MGM Camera 65 (65 mm with 1.25× anamorphic squeeze).
  /// Used only on a handful of films between 1957 and 1966 and three films in the 2010s,
  /// for some sequences of How the West Was Won (1962) with a slight crop when converted to three strip Cinerama,
  /// and films such as It's a Mad, Mad, Mad, Mad World (1963) and Ben-Hur (1959).
  /// Quentin Tarantino used it for The Hateful Eight (2015), Gareth Edwards for Rogue One (2016), Kirill Serebrennikov for Leto (2018).
  case ultraPanavision70
  
  /// 3.5:1 (32:9): In 2017, Samsung and Phillips announced 'Super UltraWide displays', with aspect ratio of 32:9.
  case ultraWide
  
  /// 3.6:1 (18:5): In 2016, IMAX announced the release of films in 'Ultra-WideScreen 3.6' format, with an aspect ratio of 36:10.
  /// Ultra-WideScreen 3.6 video format didn't spread, as cinemas in an even wider ScreenX 270° format were released.
  case ultraWideScreen
  
  /// 4:1: Rare use of Polyvision, three 35 mm 1.3:1 images projected side by side.
  /// First used in 1927 on Abel Gance's Napoléon.
  case polyvision
  
  /// 12:1: Circle-Vision 360° developed by the Walt Disney Company in 1955 for use in Disneyland.
  /// Uses nine 4:3 35 mm projectors to show an image that completely surrounds the viewer.
  /// Used in subsequent Disney theme parks and other past applications.
  case circlevision
}

extension AspectRatio {
  public var value: CGFloat {
    switch self {
    
    case .movietone:
      return 19/16
      
    case .vintageMonitor:
      return 5/4
      
    case .original35:
      return 4/3
      
    case .standard1635:
      return 48/35
      
    case .fullscreen35:
      return 11/8
      
    case .imax:
      return 1.43/1
      
    case .vistavision:
      return 3/2
      
    case .widescreen:
      return 14/9
      
    case .widescreenMonitor:
      return 16/10
      
    case .super16:
      return 5/3
      
    case .earlyWidescreen:
      return 7/4
      
    case .videoWidescreen:
      return 42/32
      
    case .ultra16:
      return 37/20
      
    case .digitalCinemaBasic:
      return 256/135
      
    case .superScope:
      return 2/1
      
    case .iPhoneX:
      return 28/13
      
    case .standard70:
      return 11/5
      
    case .cinemaScope:
      return 47/20
      
    case .cinemaDisplay:
      return 64/27
      
    case .panavision:
      return 43/18
      
    case .bluray:
      return 12/5
      
    case .cinemaScope55:
      return 23/9
      
    case .cinerama:
      return 70/27
      
    case .fullFrame:
      return 8/3
      
    case .ultraPanavision70:
      return 11/4
      
    case .ultraWide:
      return 32/9
      
    case .ultraWideScreen:
      return 18/5
      
    case .polyvision:
      return 4/1
      
    case .circlevision:
      return 12/1
    }
  }
}
