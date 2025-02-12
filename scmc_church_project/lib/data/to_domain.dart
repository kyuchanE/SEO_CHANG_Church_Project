import 'package:scmc_church_project/data/responses/bible_chapter_response.dart';
import 'package:scmc_church_project/data/responses/main_item_response.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/data/responses/version_response.dart';
import 'package:scmc_church_project/domain/models/main_carousel_data.dart';
import 'package:scmc_church_project/domain/models/version_data.dart';

/// Data entity -> Domain model 변환
extension BibleChapterResponseTransform on BibleChapterResponse {
  BibleChapterData toDomain() {
    return BibleChapterData(
      abbreviation: abbreviation,
      name: name,
      chapters: chapters,
      summary: summary,
      isOldTestament: isOldTestament,
    );
  }
}

extension VersionResponseTransform on VersionResponse {
  VersionData toDomain() {
    return VersionData(
      minAndroid: minAndroid,
      minIos: minIos,
      targetAndroid: targetAndroid,
      targetIos: targetIos,
    );
  }
}

extension MainItemResponseTransform on MainCarouselResponse {
  MainCarouselData toDomain() {
    return MainCarouselData(
      title: title,
      imageUrl: imageUrl,
      contents: contents,
      date: date,
      contentsImages: contentsImages,
    );
  }
}
