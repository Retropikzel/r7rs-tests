pipeline {

    agent {
        dockerfile {
            filename 'Dockerfile.jenkins'
            dir '.'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        choice(name: 'BUILD_IMPLEMENTATION',
               description: 'Build',
               choices: [
                 'all',
                 'chibi',
                 'chicken',
                 'cyclone',
                 'gambit',
                 'gauche',
                 'guile',
                 'kawa',
                 'loko',
                 'mit-scheme',
                 'sagittarius',
                 'stklos',
                 'skint',
                 'tr7',
               ])
    }

    stages {

        stage("Init") {
            steps {
              sh 'rm -rf srfi-test && git clone https://github.com/srfi-explorations/srfi-test.git'
              sh 'mkdir -p reports'
              sh 'touch reports/placeholder'
              stash name: 'reports', includes: 'reports/*'
              sh 'echo "<h1>Test results</h1>" > reports/results.html'
              sh '(cd srfi-test && make clean build)'
              sh 'tree srfi-test'
              stash name: 'tests', includes: 'srfi-test/*'
            }
        }

        stage("chibi") {
            agent {
                docker {
                    image 'schemers/chibi'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'chibi'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/chibi-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("chicken") {
            agent {
                docker {
                    image 'schemers/chicken'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'chicken'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/chicken-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("cyclone") {
            agent {
                docker {
                    image 'schemers/cyclone'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'cyclone'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/cyclone-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("gambit") {
            agent {
                docker {
                    image 'schemers/gambit'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'gambit'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/gambit-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("gauche") {
            agent {
                docker {
                    image 'schemers/gauche'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'gauche'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/gauche-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("guile") {
            agent {
                docker {
                    image 'schemers/guile'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'guile'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/guile-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("kawa") {
            agent {
                docker {
                    image 'schemers/kawa'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'kawa'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/kawa-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("loko") {
            agent {
                docker {
                    image 'schemers/loko:head'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'loko'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/loko-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("mit-scheme") {
            agent {
                docker {
                    image 'schemers/mit-scheme'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'mit-scheme'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/mit-scheme-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("sagittarius") {
            agent {
                docker {
                    image 'schemers/sagittarius'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'sagittarius'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/sagittarius-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("stklos") {
            agent {
                docker {
                    image 'schemers/stklos'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'stklos'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/stklos-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("skint") {
            agent {
                docker {
                    image 'schemers/skint'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'skint'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/skint-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }

        stage("tr7") {
            agent {
                docker {
                    image 'schemers/tr7'
                    reuseNode true
                }
            }
            when {
                expression {
                    params.BUILD_IMPLEMENTATION == 'all' || params.BUILD_IMPLEMENTATION == 'tr7'
                }
            }
            environment {
                MITSCHEME_LIBRARY_PATH = "${env.MITSCHEME_LIBRARY_PATH}:${env.PWD}:${env.PWD}/srfi"
                TR7_LIB_PATH = "${env.TR7_LIB_PATH}:${env.PWD}:${env.PWD}/srfi"
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'find . -maxdepth 1 -name "*.log" -delete'
                    sh 'find . -name "*.so" -delete'
                    sh 'find . -name "*.o" -delete'
                    sh 'find . -name "*.o" -delete'
                    unstash 'tests'
                    sh 'for f in *.log; do cp -- "$f" "reports/tr7-$f"; done'
                    sh 'ls reports'
                    stash name: 'reports', includes: 'reports/*'
                    archiveArtifacts artifacts: 'reports/*.log'
                }
            }
        }


        stage("Report") {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    unstash 'reports'
                    sh './report'
                    archiveArtifacts artifacts: 'reports/*.html'
                    publishHTML (target : [allowMissing: false,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: 'reports',
                        reportFiles: '*.html,*.css',
                        reportName: 'R7RS-SRFI Test Report',
                        reportTitles: 'R7RS-SRFI Test Report'])
                }
            }
        }

    }
    post {
        always {
            archiveArtifacts artifacts: 'reports/*.log'
            archiveArtifacts artifacts: 'reports/*.html'
            sh 'for f in srfi/*.sld; do snow-chibi package "$f"; done'
            archiveArtifacts artifacts: '*.tgz'
            archiveArtifacts artifacts: 'srfi/*.tgz'
            deleteDir()
        }
        failure {
            archiveArtifacts artifacts: 'reports/*.html'
            archiveArtifacts artifacts: 'reports/*.log'
            deleteDir()
        }
    }
}

