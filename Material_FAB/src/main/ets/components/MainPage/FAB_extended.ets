import { rippleUtils } from '@ohos/Material_FAB'

@Component
export struct FAB_extended {
  fabIcon: string | Resource = ''
  fabLabel: string | Resource = ''
  @State fontColor: Color | string  = Color.White
  @State position: {
    x: number,
    y: number
  } = { x: 0, y: 0 }
  @State maxWidth: number = 200
  @State private currFabSize: {
    width: number,
    height: number
  } = { width: 80, height: 56 }
  @State borderRadius: number = 16
  @State rippleColor: Color = Color.White
  onClick: (event?: ClickEvent) => void
  @State private iconSize: {
    width: number,
    height: number
  } = { width: 24, height: 24 }

  //ripple rendering control
  @State private showRipple : boolean = true
  @State clickCoordinates : {x : number , y : number} = {x : 0, y : 0}

  here(){
    new rippleUtils({
      size: this.currFabSize,
      _radius: this.borderRadius,
      rippleColor: Color.White

    })
  }

  build() {
    Row() {
      if (this.fabIcon != '') {
        Image(this.fabIcon)
          .size(this.iconSize)
          .objectFit(ImageFit.Cover)
          .margin({ left: 20 })
      }

      Text(this.fabLabel)
        .fontColor(this.fontColor)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .margin({ left: 20, right: 20 })
        .alignSelf(ItemAlign.Auto)
        .align(Alignment.Start)


//      rippleUtils({
//        size: $currFabSize,
//        _radius: $borderRadius,
//        rippleColor: $rippleColor,
//
//      })

    }
    .constraintSize({ minWidth: 80, maxWidth: this.maxWidth })
    .height(56)
    .backgroundColor(Color.Blue)
    .borderRadius(this.borderRadius)
    .zIndex(99999999)
    .shadow({ radius: 30, color: Color.Gray, offsetY: 16 })
    .position(this.position)
    .onAreaChange((oldValues, newValues) => {
      this.currFabSize.width = parseFloat(newValues.width.toString())
    })
    .onClick((event) => {
      this.here()
      console.log('clicked')
    })
  }
}
