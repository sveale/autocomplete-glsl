#version 410 core
#define DIFFUSE		0
#define POSITION	1
#define NORMAL		2

layout(location = DIFFUSE) in vec3 diffuse;
layout(location = POSITION) in vec3 position;
layout(location = NORMAL) in vec3 normal;

out VS_OUT
{
    vec3 position;
    vec3 diffuse;
    vec3 normal;
} vs_out;

vec3 thisIsAFunction()
{
  return vec3(1, 1, 1);
}

void main() {
    vs_out.diffuse = diffuse;
    vs_out.position = position;
    vs_out.normal = normal;
}
