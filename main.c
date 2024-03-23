#include "raylib.h"

int main(void) {
  const int screenWidth = 800;
  const int screenHeight = 450;

  InitWindow(screenWidth, screenHeight, "Hello Xcode");

  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    BeginDrawing();

    ClearBackground(RAYWHITE);

    DrawText("Hello, Xcode!", 335, 200, 20, BLUE);

    EndDrawing();
  }

  CloseWindow();

  return 0;
}
