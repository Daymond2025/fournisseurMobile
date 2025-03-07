<?php
namespace App\Http\Controllers\api\v2\supplier;

use App\Http\Controllers\Controller;
use App\Http\Resources\ShopDetailResource;
use App\Http\Resources\ShopResource;
use App\Models\PhoneNumber;
use App\Models\Shop;
use App\Models\Supplier;
use App\Models\User;
use App\Traits\HttpResponse;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use PhpParser\ErrorHandler\Throwing;

class ShopController extends Controller
{

    use HttpResponse;

    public function store(Request $request)
    {
        try{

            if ($request->code) {
                $validator = Validator::make($request->all(), [
                    'code' => 'required|exists:password_reset_tokens,code'
                ]);

                if ($validator->fails())
                    return $this->error(
                        code: 422,
                        data: ['error' => $validator->errors()],
                        message: "Le code est erronné"
                    );
            }

            $validator = Validator::make($request->all(), [
                'city_id' => 'required|integer|exists:cities,id',
                'business_id' => 'nullable|integer',
                'name' => 'required|string',
                'address' => 'required|string',
                'email' => 'required|string',
                'phone_number_shop' => 'required|string',
                'phone_number' => 'required|string',
                'first_name' => 'required|string',
                'last_name' => 'nullable|string',
                'shop_picture' => 'nullable|array',
                'categories_product' => 'nullable|array',
                'picture_path' => 'nullable|mimes:jpeg,png,jpg|max:524'
            ]);

            if ($validator->fails())
                return $this->error(
                    code: 422,
                    data: ['error' => $validator->errors()],
                    message: $validator->errors()->first()
                );

            // DB::table("password_reset_tokens")->where('code', $request->password)->delete();

            $doc = [];
                if ($request->shop_picture) {
                    foreach ($request->shop_picture as $key => $value) {
                        $doc[] = saveImage($value, $key, 'docs');
                    }
                }

            $picture = null;
            if ($request->file('picture_path'))
                $picture = saveImage($request->picture_path, 0, 'docs');
            
            $user = User::create([
                'phone_number' => $request->phone_number,
                'roles_as' => json_encode(['supplier']),
                'phone_number_2' => $request->phone_number_shop ?? null,
                'picture_path' => $picture,
                'is_locked' => false,
                'email' => $request->email,
                'password' => Hash::make('password'),
            ]);

            $business = Business::create([
                'logo'=> $picture,
                'name'=> $request->name,
                'ncc' => "defaut",
                'email'=> $request->email,
                'phone_number' => $request->phone_number,
                'address'=> $request->address,
                'register_path'=> $picture,
            ])
    
            $shop = Shop::create([
                'code' => generateCode("SHOP"),
                'name' => $request->name,
                'city_id' => $request->city_id,
                'business_id' => $business->id,
                'address' => $request->address,
                'email' => $request->email,
                'phone_number' => $request->phone_number,
                'shop_picture' => count($doc) > 0 ? json_encode($doc) : null,

            ]);
    
            Supplier::create([
                'user_id' => $user->id,
                'shop_id' => $shop->id,
                'business_id' => => $business->id,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'categories_product' => json_encode($request->categories_product),
                
            ]);

            Wallet::create([
                'person' => BUSINESS,
                'person_id' => $business->id,
                'amount' => 0,
                'total_amount' => 0,
            ]);

            

            PhoneNumber::create([
                'operator' => $request->operator_withdrawal,
                'phone_number' => $request->phone_number,
                'person' => BUSINESS,
                'person_id' => $business->id,
            ]);

            return $this->success(
                data: [],
                message: 'Magasin créé avec succès',
                code: 201,
            );
        }
        catch (Exception $e) {
            Log::error($e->getMessage());
            return $this->error(
                code: 500,
                data: ['error' => $e->getMessage()],
                message: 'Erreur interne du serveur',
            );
        }
        
    }

    public function envoiCode(Request $request)
    {
        try{

            $request->validate([
                'email' => 'required|email',
            ]);

            $token = generateCode(model: 'T', length: 64);
            $code = rand(10000, 99999);

            DB::table(table: 'password_reset_tokens')->updateOrInsert(
                attributes: ['email' => $request->email],
                values: [
                    'token' => $token,
                    'code' => $code,
                    'created_at' => now(),
                ]
            );

            // Trouver l'utilisateur
            $user = User::where('email', $request->email)->first();
            if ($user) {
                // Mettre à jour le mot de passe (hashé)
                $user->password = Hash::make($code);
                $user->save();
            }

            Mail::send(view: 'email.send_code_register_recruiter', data: ['code' => $code], callback: function ($message) use ($request): void {
                $message->to($request->email);
                $message->subject('Code de confirmation');
            });

            return $this->success(
                code: 200,
                data: [],
                message: 'Code envoyé par mail.'
            );

        }
        catch (Exception $e) {
            Log::error($e->getMessage());
            return $this->error(
                code: 500,
                data: [],
                message: 'Veuillez réessayer',
            );
        }
    }

}