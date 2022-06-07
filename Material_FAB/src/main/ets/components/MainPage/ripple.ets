
@Component
export struct rippleUtils {
  @State private rippleSize: number = 10
  @State private rippleX: number = 30
  @State private rippleY: number = 10
  @State private rippleScale: number = 0
  @State private rippleVisible: boolean = true
  @State private opacity: number = 0.4

  @Link rippleColor: Color

  // click event coordinates
  @State rippleStartPosition: {
    x: number,
    y: number
  } = { x: 40, y: 20 }

  // ripple flex container attributes
  @Link size: {
    width: number,
    height: number
  }
  @Link _radius: number

  ripple_animation() {
    animateTo({
      duration: 300,
      curve: Curve.Ease,
      onFinish: () => {
        this.rippleScale = 0
        this.rippleVisible = false
      }
    },
      () => {
        this.rippleScale = Math.ceil(Math.sqrt(Math.pow(this.size.width, 2) + Math.pow(this.size.height, 2)) * 2 / this.rippleSize)
      })
  }


  build() {
    Flex() {
      Circle()
        .visibility(this.rippleVisible ? Visibility.Visible : Visibility.Hidden)
        .fill(this.rippleColor)
        .width(this.rippleSize)
        .height(this.rippleSize)
        .opacity(this.opacity)
        .position({ x: this.rippleX, y: this.rippleY })
        .scale({
          x: this.rippleScale,
          y: this.rippleScale,
          centerX: this.rippleSize / 2,
          centerY: this.rippleSize / 2
        })
    }
    .clip(true)
    .size(this.size)
    .position({ x: 0, y: 0 })
    .zIndex(2)
    .borderRadius(this._radius)
    .onAppear(() => {
      this.rippleVisible = true
      this.rippleX = this.rippleStartPosition.x - this.rippleSize / 2
      this.rippleY = this.rippleStartPosition.y - this.rippleSize / 2

      this.ripple_animation()
    })
  }
}