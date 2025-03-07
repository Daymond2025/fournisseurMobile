<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Exécute la migration.
     */
    public function up(): void
    {
        Schema::table('shops', function (Blueprint $table) {
            $table->json('shop_picture')->nullable()->after('name'); // Liste d'URLs d'images
        });

        Schema::table('suppliers', function (Blueprint $table) {
            $table->json('categories_product')->nullable()->after('shop_id'); // Liste de JSON
        });
    }

    /**
     * Annule la migration.
     */
    public function down(): void
    {
        Schema::table('shops', function (Blueprint $table) {
            $table->dropColumn('shop_picture');
        });

        Schema::table('suppliers', function (Blueprint $table) {
            $table->dropColumn('categories_product');
        });
    }
};
