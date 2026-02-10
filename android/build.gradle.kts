
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// C'est ici qu'on définit la version de Kotlin pour tout le projet
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // On force une version de Kotlin moderne (1.9.10)
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10")
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
            force("androidx.activity:activity:1.9.3")
            force("androidx.browser:browser:1.8.0")
        }
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}