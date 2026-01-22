package com.morevocab.more_vocab

import android.app.Application

class MoreVocabApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Engine pre-warming disabled to fix splash screen timing issues
        // The default FlutterActivity will create its own engine on demand
    }
}
