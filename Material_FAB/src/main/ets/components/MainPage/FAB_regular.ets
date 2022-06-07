import { rippleUtils } from '@ohos/Material_FAB'


@Component
export struct FAB_regular {
  fabIcon: string | Resource
  @State position: {
    x: number,
    y: number
  } = { x: 0, y: 0 }
  @State fabType: string = 'FAB'
  @State bgColor: Color | string = Color.Blue
  @State rippleColor: Color | string = Color.White
  @State borderRadius: number = 16
  @State iconSize: number = 24
  @State containerSize: {
    width: number,
    height: number
  } = { width: 56, height: 56 }
  onClick: (event?: ClickEvent) => void
  private sizeSpecs = {
    "small-FAB": {
      containerSize: 40,
      iconSize: 24,
      borderRadius: 12
    },
    "FAB": {
      containerSize: 56,
      iconSize: 24,
      borderRadius: 16
    },
    "large-FAB": {
      containerSize: 96,
      iconSize: 36,
      borderRadius: 28
    },
  }

  aboutToAppear() {
    this.borderRadius = this.sizeSpecs[this.fabType].borderRadius
    this.containerSize = {
      width: this.sizeSpecs[this.fabType].containerSize,
      height: this.sizeSpecs[this.fabType].containerSize
    }
    this.iconSize = this.sizeSpecs[this.fabType].iconSize
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Image(this.fabIcon)
        .width(this.sizeSpecs[this.fabType].iconSize)
        .height(this.sizeSpecs[this.fabType].iconSize)
        .objectFit(ImageFit.Cover)

      rippleUtils({
        size: $containerSize,
        _radius: $borderRadius,
        rippleColor: $rippleColor,
      })
    }
    .size(this.containerSize)
    .backgroundColor(this.bgColor)
    .border({ radius: this.borderRadius, width: 0 })
    .zIndex(99999)
    .shadow({ radius: 30, color: Color.Gray, offsetY: 16 })
    .position(this.position)

  }
}
