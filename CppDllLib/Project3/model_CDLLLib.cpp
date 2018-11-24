#include "model_CDLLLib.h"
#include <ctime>
#include <cstdlib>

JNIEXPORT void JNICALL Java_model_CDLLLib_BarnsleyFernAlgorithm
(JNIEnv * env, jobject object, jfloatArray points, jint pointsCount,
	jfloat startX, jfloat startY, jfloat e1, jfloat e2, jfloat e3, jfloat e4, 
	jfloat f1, jfloat f2, jfloat f3, jfloat f4) {

	srand(time(nullptr));
	int p;
	jfloat *pointsArray = nullptr;
	pointsArray = env->GetFloatArrayElements(points, false);
	for (int i = 0; i < pointsCount; i=i+2)
	{
		p = rand() % 100;
		if (p <= 2) {
				startX = 0 + e1;
				startY = 0.16f * startY + f1;
		}
		else if (p <= 86) {
				startX = 0.85f * startX + 0.04f * startY + e2;
				startY = -0.04f * startX + 0.85f * startY + 1.6f + f2;
		}
		else if (p <= 93) {
				startX = 0.2f * startX - 0.26f * startY + e3;
				startY = 0.23f * startX + 0.22f * startY + 1.6f + f3;
		}
		else {
				startX = -0.15f * startX + 0.28f * startY + e4;
				startY = 0.26f * startX + 0.24f * startY + 0.44f + f4;
		}
		pointsArray[i] = startX;
		pointsArray[i + 1] = startY;
	}

	env->ReleaseFloatArrayElements(points, pointsArray, JNI_COMMIT);
}