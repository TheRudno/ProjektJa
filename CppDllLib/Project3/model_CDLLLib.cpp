#include "model_CDLLLib.h"
#include <random>

JNIEXPORT void JNICALL Java_model_CDLLLib_BarnsleyFernAlgorithm
(JNIEnv * env, jobject object, jfloatArray points, jint pointsCount,
	jfloat startX, jfloat startY, jfloat e1, jfloat e2, jfloat e3, jfloat e4, 
	jfloat f1, jfloat f2, jfloat f3, jfloat f4) {

	std::random_device rd; // obtain a random number from hardware
	std::mt19937 eng(rd()); // seed the generator
	std::uniform_int_distribution<> distr(0, 100); // define the range
	int p;
	jfloat *pointsArray = nullptr;
	pointsArray = env->GetFloatArrayElements(points, false);
	float x, y;
	for (int i = 0; i < pointsCount; i=i+2)
	{
		x = startX;
		y = startY;
		p = distr(eng);
		if (p <= 2) {
			startX = 0 + e1;
			startY = 0.16f * y + f1;
		}
		else if (p <= 86) {
			startX = 0.85f * x + 0.04f * y + e2;
			startY = -0.04f * x + 0.85f * y + f2;
		}
		else if (p <= 93) {
			startX = 0.2f * x - 0.26f * y + e3;
			startY = 0.23f * x + 0.22f * y + f3;
		}
		else {
			startX = -0.15f * x + 0.28f * y + e4;
			startY = 0.26f * x + 0.24f * y + f4;
		}
		pointsArray[i] = startX;
		pointsArray[i + 1] = startY;
	}

	env->ReleaseFloatArrayElements(points, pointsArray, JNI_COMMIT);
}