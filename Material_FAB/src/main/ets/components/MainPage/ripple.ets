@Component
export struct rippleUtils {
  rippleDuration : number = 300
  unbounded : boolean = false
  color: ResourceColor = Color.Red // fill color of the circle

  private rippleSize: number = 10
  private opacity: number = 0.4

  @State private rippleX: number = 0
  @State private rippleY: number = 0
  @State private rippleScale: number = 0 // current scale of circle

  @Link showRipple: boolean // for rendering control

  @Link rippleStartPosition: { // click event coordinates
    x: number,
    y: number
  }
  @Link size: {width: number, height : number } // size of ripple container
  @Link border: BorderOptions // radius of ripple container


  ripple_animation() {
    this.rippleX = this.rippleStartPosition.x - this.rippleSize / 2
    this.rippleY = this.rippleStartPosition.y - this.rippleSize / 2
    animateTo({
      duration: this.rippleDuration,
      curve: Curve.Sharp,
      onFinish: () => {
        this.rippleScale = 0
        this.showRipple = false
      }
    },
      () => {
        this.rippleScale = Math.ceil(Math.sqrt(Math.pow(this.size.width, 2) + Math.pow(this.size.height, 2)) * 2 / this.rippleSize)
      })
  }

  build() {
    if (this.showRipple) {
      Flex() {
        Circle()
          .fill(this.color)
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
      .clip(!this.unbounded)
      .size(this.size)
      .position({ x: 0, y: 0 })
      .zIndex(2)
      .border(this.border)
      .onAppear(() => {
        this.ripple_animation()
      })
    }
  }
}