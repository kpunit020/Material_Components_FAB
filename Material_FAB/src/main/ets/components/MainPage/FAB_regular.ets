import { rippleUtils } from '@ohos/Material_FAB'


@Component
export struct FAB_regular {
  fabSize: string = 'medium'  // use pre-defined sizes

  // icon attributes
  fabIcon: ResourceStr
  iconSize: SizeOptions

  //container attributes
  position: Position = { x: 0, y: 0 }
  backgroundColor: ResourceColor = Color.Blue
  @State border: BorderOptions = {}  // set custom border config
  fabCustomSize: SizeOptions // set custom container size
  @State private containerSize: SizeOptions = {}
  margin : Margin

  @State private clickCoordinates: Position = { x: 0, y: 0 } // click event coordinates
  @State private showRipple: boolean = false // for ripple rendering control
  rippleColor: ResourceColor = Color.White  // set custom ripple color

  onClick: (event?: ClickEvent) => void = (event) => {  // callback for onClick
    console.log('FAB_regular clicked')
  }


  // size specifications for different fab_regular
  private sizeSpecs = {
    "small": {
      containerSize: 40,
      iconSize: 24,
      borderRadius: 12
    },
    "medium": {
      containerSize: 56,
      iconSize: 24,
      borderRadius: 16
    },
    "large": {
      containerSize: 96,
      iconSize: 36,
      borderRadius: 28
    },
  }

  aboutToAppear() {
    this.border.radius = this.border.radius? this.border.radius : this.sizeSpecs[this.fabSize].borderRadius

    this.containerSize = (this.fabCustomSize) ? this.fabCustomSize : {
                                                                       width: this.sizeSpecs[this.fabSize].containerSize,
                                                                       height: this.sizeSpecs[this.fabSize].containerSize
                                                                     }


    this.iconSize = this.iconSize ? this.iconSize : {
                                                      width: this.sizeSpecs[this.fabSize].iconSize,
                                                      height: this.sizeSpecs[this.fabSize].iconSize
                                                    }
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Image(this.fabIcon)
        .size(this.iconSize)
        .objectFit(ImageFit.Cover)

      rippleUtils({
        size: $containerSize,
        border: $border,
        rippleStartPosition: $clickCoordinates,
        showRipple: $showRipple,
        color: this.rippleColor,
      })
    }
    .size(this.containerSize)
    .backgroundColor(this.backgroundColor)
    .border(this.border)
    .zIndex(99999)
    .shadow({ radius: 30, color: Color.Gray, offsetY: 16 })
    .position(this.position)
    .margin(this.margin)
    .onClick((event) => {
      this.clickCoordinates = {
        x: event.x,
        y: event.y
      }
      this.showRipple = true
      this.onClick(event)
    })
    .onMouse()
  }
}
