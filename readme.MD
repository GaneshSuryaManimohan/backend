# 🚀 Jenkins CI/CD Pipeline – Backend Application

This `Jenkinsfile` defines a **Declarative Jenkins Pipeline** that builds a Node.js backend application, packages it as a versioned artifact, uploads it to Nexus Repository, and then triggers a separate deployment job.

---

## 📌 High-Level Workflow

1. Read version from package.json

2. Install dependencies (npm install)

3. Build versioned ZIP artifact

4. Upload artifact to Nexus

5. Trigger deployment job

6. Clean workspace


---

# 🧩 Pipeline Configuration

## 🖥 Agent

```groovy
agent {
    label 'AGENT-1'
}
```
* Runs on a Jenkins agent labeled AGENT-1

---

⚙️ Pipeline Options

options {
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
    ansiColor('xterm')
}

| Option                     | Purpose                                           |
|----------------------------|---------------------------------------------------|
| `timeout`                  | Aborts the pipeline if it exceeds 30 minutes      |
| `disableConcurrentBuilds()`| Prevents parallel builds of the same job          |
| `ansiColor('xterm')`       | Enables colored console output in the console log |

---

🌍 Environment Variables

environment {
    APP_VERSION = ''
    NEXUS_URL = 'nexus.surya-devops.site:8081'
}


| Variable                   | Description                                       |
|----------------------------|---------------------------------------------------|
| `APP_VERSION`              | Stores application version dynamically            |
| `NEXUS_URL`                | Nexus repository server address                   |

---
🏗 Pipeline Stages

1️⃣ Read the Version

def packageJson = readJSON file : 'package.json'
APP_VERSION = packageJson.version

#### What It Does
1. Reads package.json

2. Extracts the version field

3. Assigns it to APP_VERSION

4. Prints the version in console
✅ Ensures artifact version matches application version.

2️⃣ Install Dependencies
```bash
npm install
ls -lrth
echo "application version: ${APP_VERSION}"
```
#### What It Does

1. Installs Node.js dependencies

2. Lists files in workspace

3. Prints application version

3️⃣ Build Stage

```bash
zip -q -r backend-${APP_VERSION}.zip * -x Jenkinsfile -x backend-${APP_VERSION}.zip
ls -ltr
```
#### What It Does? 

* Creates a versioned ZIP file:
    - backend-<version>.zip
    - Example: backend-1.0.3.zip
* Excludes:
    - Jenkinsfile
    - The generated ZIP file itself

4️⃣ Nexus Artifact Upload4️⃣ Nexus Artifact Upload

Uses `nexusArtifactUploader` to upload the artifact to Nexus 3.

* Configuration: 
    - Nexus Version: nexus3
    - Protocol: http
    - Repository: backend
    - Group ID: com.expense
    - Artifact ID: backend
    - Version: ${APP_VERSION}
    - Type: zip
    - Credentials ID: nexus_auth

* Artifact Structure in Nexus: `com/expense/backend/<version>/backend-<version>.zip`
    Example: `com/expense/backend/1.0.3/backend-1.0.3.zip`

5️⃣ Deploy Stage

build job: 'backend-deploy', parameters: params, wait: false

#### What It Does?

* Triggers another Jenkins job named: `backend-deploy`
* Passes parameter: `APP_VERSION=<current version>`
* wait: false → Deployment runs asynchronously.
    - This separates CI (build) from CD (deployment).

🔄 Post Actions
```groovy
post {
    always {
        echo 'I will always say hello'
        deleteDir()
    }
    success {
        echo 'Shows Only upon success'
    }
    failure {
        echo 'shows upon failure'
    }
}
```

**Behavior**

* Always: 
    - Prints a message
    - Cleans workspace using deleteDir()

* Success: Prints success message

* Failure: Prints failure message

📦 Complete CI/CD Flow

Developer Push
      ↓
Jenkins Pipeline Triggered
      ↓
Read Version from package.json
      ↓
npm install
      ↓
Create versioned ZIP artifact
      ↓
Upload artifact to Nexus
      ↓
Trigger backend-deploy job
      ↓
Clean workspace

🛡 Best Practices Implemented

* Version-controlled artifacts
* Workspace cleanup after execution
* No concurrent build conflicts
* Build timeout protection
* Centralized artifact repository (Nexus)
* Separation of build and deploy stages

📋 Prerequisites

* Jenkins agent labeled `AGENT-1`
* Node.js installed on agent
* `package.json` present in repository
* Nexus 3 running at `nexus.surya-devops.site:8081`
* Jenkins credential ID: `nexus_auth`
* Existing Jenkins job: `backend-deploy`

🎯 Summary

* This pipeline implements a structured CI/CD approach:
* Builds a Node.js backend application
* Creates a versioned artifact
* Stores artifact in Nexus Repository
* Triggers a separate deployment job
* Ensures controlled and clean execution







