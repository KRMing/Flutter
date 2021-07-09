import 'package:flutter/material.dart';
import 'dart:math';

class SizeConfig {

  static final double ogWidth = 411.42857142857144;
  static final double ogHeight = 683.4285714285714;
  double? _width;
  double? _height;
  double scaleFactor;
  double orthoScale;

  SizeConfig(this._width, this._height, {this.scaleFactor = 1.0, this.orthoScale = 1.0}) {

    if (this._width == null || this._height == null) {
      this._width = ogWidth;
      this._height = ogHeight;
    }

    double widthDiff = (ogWidth - this._width! < 0) ? this._width! - ogWidth : ogWidth - this._width!;
    double heightDiff = (ogHeight - this._height! < 0) ? this._height! - ogHeight : ogHeight - this._height!;
    double diagLength = sqrt(ogWidth * ogWidth + ogHeight * ogHeight);
    this.scaleFactor = diagLength / (diagLength + sqrt(widthDiff * widthDiff + heightDiff * heightDiff));
    this.orthoScale = 1 / this.scaleFactor;
  }
}