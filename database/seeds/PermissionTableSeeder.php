<?php

use App\Models\Permission;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class PermissionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();
        Permission::truncate();

        $Permissions = [
            'User List',
            'User Create',
            'User Edit',
            'User Delete',
            'Role List',
            'Role Create',
            'Role Edit',
            'Role Delete',
            'Permission List',
            'Permission Create',
            'Permission Edit',
            'Permission Delete',
            'Category List',
            'Category Create',
            'Category Edit',
            'Category Delete',
            'Article List',
            'Article Create',
            'Article Edit',
            'Article Delete',
            'Team List',
            'Team Create',
            'Team Edit',
            'Team Delete',
            'Quiz Form List',
            'Quiz Form Create',
            'Quiz Form Edit',
            'Quiz Form Delete',

        ];


        foreach ($Permissions as $Permission) {

            Permission::Create(['name' => $Permission, 'slug' => \App\Helpers\Helper::slugify($Permission)]);

        }

        Schema::enableForeignKeyConstraints();
    }
}
