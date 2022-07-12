<template>
<h2 class="title is-3 has-text-grey">新規投稿</h2>
<b-field label="タイトル">
  <b-input v-model="title" required></b-input>
</b-field>
<b-field label="メモ">
  <b-input rows="2" maxlength="100" type="textarea" v-model="memo"></b-input>
</b-field>

<b-field>
  <b-upload v-model="file" drag-drop required>
    <section class="section">
      <div class="content has-text-centered">
        <p>
          <b-icon icon="upload" size="is-large"> </b-icon>
        </p>
        <p>画像ファイルをドロップしてください。</p>
      </div>
    </section>
  </b-upload>
</b-field>
<div class="tags">
  <span class="tag is-primary" v-if="file">
    {{ file.name }}
    <button class="delete" type="button"
      @click="this.file = null"
    ></button>
  </span>
</div>
<b-button type="is-primary" outlined @click="create()">送信</b-button>